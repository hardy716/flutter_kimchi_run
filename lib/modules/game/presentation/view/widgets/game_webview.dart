import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/default_constants.dart';
import '../view_model/ranking_view_model.dart';
import '../view_model/game_view_model.dart';
import '../state/game_state.dart';

class GameWebView extends ConsumerStatefulWidget {
  const GameWebView({super.key});

  @override
  ConsumerState<GameWebView> createState() => GameWebViewState();
}

final GlobalKey<GameWebViewState> gameWebViewKey = GlobalKey<GameWebViewState>();

class GameWebViewState extends ConsumerState<GameWebView> {
  InAppWebViewController? webViewController;

  void _handleUnityMessage(String message) {
    try {
      final data = jsonDecode(message);
      final String type = data['type'] ?? '';
      final dynamic payload = data['data'];

      debugPrint('📦 Parsed Unity message - type: $type, data: $payload');

      switch (type) {
        case 'unity_ready':
          ref.game.setUnityReady(true);
          debugPrint('🎮 Unity is ready!');
          break;

        case 'game_over':
          debugPrint('🎮 Unity Game Over!');
          break;

        // UI State Messages
        case 'ui_state_start':
          ref.game.updateGameUI(GameUI.START);
          debugPrint('🎮 Unity UI State: Start');
          break;

        case 'ui_state_playing':
          ref.game.updateGameUI(GameUI.PLAYING);
          debugPrint('🎮 Unity UI State: Playing');
          break;

        case 'ui_state_finish':
          ref.game.updateGameUI(GameUI.FINISH);
          debugPrint('🎮 Unity UI State: Finish');
          break;

        // Game State Messages
        case 'game_restarting':
          debugPrint('🎮 Unity Game: Restarting');
          break;

        case 'game_started':
          debugPrint('🎮 Unity Game: Started');
          break;

        case 'game_paused':
          debugPrint('🎮 Unity Game: Paused');
          break;

        case 'game_resumed':
          debugPrint('🎮 Unity Game: Resumed');
          break;

        case 'game_ready':
          debugPrint('🎮 Unity Game Status: Ready');
          break;

        case 'game_playing':
          debugPrint('🎮 Unity Game Status: Playing');
          break;

        case 'game_finished':
          debugPrint('🎮 Unity Game Status: Finished');
          break;

        // Score Message
        case 'unity_game_score':
          if (payload != null) {
            try {
              Map<String, dynamic> scoreData;
              if (payload is String) {
                scoreData = jsonDecode(payload);
              } else {
                scoreData = payload as Map<String, dynamic>;
              }
              
              final int newScore = scoreData['newScore'] ?? 0;
              final int highScore = scoreData['highScore'] ?? 0;

              ref.ranking.updateRankingUer(highScore: highScore);

              debugPrint('🎮 Unity Game Score: newScore=$newScore, highScore=$highScore');
            } catch (e) {
              debugPrint('❌ Error parsing unity_game_score: $e');
            }
          }
          break;

        default:
          debugPrint('⚠️ Unhandled Unity message type: $type');
          break;
      }
    } catch (e) {
      debugPrint('Unity 메시지 처리 오류: $e');
    }
  }

  // Unity에 게임 상태 확인 메시지 전송
  void _checkGameStatus() {
    if (webViewController != null) {
      webViewController!.evaluateJavascript(
        source: '''
          console.log('🔍 Checking game status...');
          if (typeof window.sendToUnity === 'function') {
            window.sendToUnity('GameManager', 'RequestGameStatus', '');
          } else {
            console.warn('Unity communication not ready for status check');
          }
        ''',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(gameViewModelProvider, (prev, next) {
      if (next.isUnityReady && (prev?.isUnityReady != true)) {
        Future.delayed(const Duration(milliseconds: 500), () {
          _checkGameStatus();
        });
      }
    });

    return InAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(DefaultConstants.unityWebGLUrl)),
      initialSettings: InAppWebViewSettings(
        isInspectable: true,
        mediaPlaybackRequiresUserGesture: false,
        allowsInlineMediaPlayback: true,
        iframeAllowFullscreen: true,
        javaScriptEnabled: true,
        domStorageEnabled: true,
        databaseEnabled: true,
        clearCache: false,
        cacheEnabled: true,
        hardwareAcceleration: true,
        supportZoom: false,
        builtInZoomControls: false,
        displayZoomControls: false,
        useShouldOverrideUrlLoading: true,
        allowsLinkPreview: false,
        allowsBackForwardNavigationGestures: false,
      ),
      onWebViewCreated: (controller) {
        webViewController = controller;
        
        // Unity 메시지 핸들러 등록
        controller.addJavaScriptHandler(
          handlerName: 'FlutterUnityBridge',
          callback: (args) {
            if (args.isNotEmpty) {
              _handleUnityMessage(args[0].toString());
            }
          },
        );
      },
      onLoadStart: (controller, url) => ref.game.setLoading(true),
      onLoadStop: (controller, url) async {
        ref.game.setLoading(false);
        
        await controller.evaluateJavascript(
          source: '''
            // 기본 CSS 설정 (Unity 비율 보존)
            const style = document.createElement('style');
            style.textContent = `
              body, html {
                margin: 0;
                padding: 0;
                background: #000;
              }
            `;
            document.head.appendChild(style);
            
            // Flutter-Unity 통신 브릿지 설정
            window.sendToFlutter = function(type, data) {
              const message = JSON.stringify({type: type, data: data});
              console.log('📨 Received from Unity:', type, data);
              if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
                window.flutter_inappwebview.callHandler('FlutterUnityBridge', message);
                console.log('✅ Message forwarded to Flutter');
              } else {
                console.warn('❌ Flutter bridge not available');
              }
            };

            // Unity에서 DllImport로 호출할 수 있는 함수
            window.SendUnityMessageToFlutter = function(messageType, data) {
              console.log('📨 DllImport call from Unity:', messageType, data);
              window.sendToFlutter(messageType, data);
            };
            
            // Unity에서 점수 전송을 위한 함수 (Unity FlutterCommunication.cs에서 호출)
            window.SendScoreToFlutter = function(newScore, highScore) {
              console.log('SendScoreToFlutter called with:', newScore, highScore);
              const scoreData = {
                newScore: parseInt(newScore),
                highScore: parseInt(highScore)
              };
              
              // receiveGameScore 핸들러로 전송
              if (window.flutter_inappwebview && window.flutter_inappwebview.callHandler) {
                window.flutter_inappwebview.callHandler('receiveGameScore', scoreData);
                console.log('Score data sent to Flutter:', scoreData);
              } else {
                console.error('Flutter bridge not available for score transmission');
              }
            };
            
            window.sendToUnity = function(gameObject, method, parameter) {
              if (typeof unityInstance !== 'undefined' && unityInstance) {
                try {
                  unityInstance.SendMessage(gameObject, method, parameter);
                  console.log('Sent to Unity:', gameObject, method, parameter);
                  return true;
                } catch (e) {
                  console.error('Unity SendMessage failed:', e);
                  return false;
                }
              }
              console.warn('Unity instance not available');
              return false;
            };
            
            // 터치 이벤트 제어 함수
            window.setTouchEnabled = function(enabled) {
              const canvas = unityInstance && unityInstance.Module && unityInstance.Module.canvas;
              if (canvas) {
                if (enabled) {
                  canvas.style.pointerEvents = 'auto';
                  canvas.style.touchAction = 'manipulation';
                  console.log('Touch events enabled');
                } else {
                  canvas.style.pointerEvents = 'none';
                  canvas.style.touchAction = 'none';
                  console.log('Touch events disabled');
                }
              } else {
                console.warn('Canvas not found for touch control');
              }
            };
            
            // 개선된 Unity 로드 감지 및 통신 설정
            let unityCheckInterval;
            let unityLoadWaitCount = 0;
            const maxWaitSeconds = 30;
            let unityReady = false;
            
            function checkUnityLoaded() {
              const canvas = document.querySelector('canvas');
              unityLoadWaitCount++;
              
              if (!canvas) {
                console.log('⏳ Waiting for Unity canvas... (' + unityLoadWaitCount + '/' + maxWaitSeconds + ')');
                if (unityLoadWaitCount < maxWaitSeconds) {
                  setTimeout(checkUnityLoaded, 1000);
                }
                return;
              }
              
              // Unity가 로드되어서 캔버스가 있으면 기본 설정만
              console.log('🎉 Unity canvas detected! Using default Unity layout...');
              
              // 기본 캔버스 설정 (Unity 기본 비율 유지)
              canvas.tabIndex = 0;
              canvas.focus();
              console.log('✅ Canvas ready with Unity default settings');
              
              // 더 강력한 Unity SendMessage 함수 설정
              window.sendToUnity = function(gameObject, method, parameter) {
                console.log('📨 Unity message request: ' + gameObject + '.' + method + '(' + parameter + ')');
                
                // Unity 인스턴스 찾기 - 더 광범위한 검색
                const candidates = [
                  window.unityInstance,
                  window.gameInstance, 
                  window.Module,
                  window.unityGame,
                  window.unity,
                  window.Unity,
                  // 전역 변수로 시도
                  typeof unityInstance !== 'undefined' ? unityInstance : null,
                  typeof gameInstance !== 'undefined' ? gameInstance : null
                ];
                
                let found = false;
                
                // 먼저 인스턴스를 통한 호출 시도
                for (let instance of candidates) {
                  if (instance && typeof instance.SendMessage === 'function') {
                    try {
                      instance.SendMessage(gameObject, method, parameter);
                      console.log('✅ Unity message sent successfully via instance');
                      found = true;
                      break;
                    } catch (e) {
                      console.warn('Unity SendMessage failed for candidate:', e);
                    }
                  }
                }
                
                // 전역 SendMessage 함수로 시도
                if (!found && typeof SendMessage === 'function') {
                  try {
                    SendMessage(gameObject, method, parameter);
                    console.log('✅ Unity message sent via global SendMessage');
                    found = true;
                  } catch (e) {
                    console.warn('Global SendMessage failed:', e);
                  }
                }
                
                // 지연 실행 시도 (Unity 로드가 완료되지 않은 경우)
                if (!found) {
                  setTimeout(() => {
                    console.log('🔄 Retrying Unity message after delay...');
                    // 다시 시도
                    for (let instance of candidates) {
                      if (instance && typeof instance.SendMessage === 'function') {
                        try {
                          instance.SendMessage(gameObject, method, parameter);
                          console.log('✅ Unity message sent successfully via delayed attempt');
                          return true;
                        } catch (e) {
                          // 조용히 실패
                        }
                      }
                    }
                    console.warn('⚠️ Unity SendMessage still not available after delay');
                  }, 1000);
                  
                  console.warn('⚠️ Unity SendMessage not available yet, will retry in 1 second');
                }
                
                return found;
              };
              
              // Unity 준비 상태 알림 (약간의 지연 후)
              setTimeout(() => {
                if (!unityReady) {
                  console.log('🎮 Notifying Flutter that Unity is ready...');
                  if (window.sendToFlutter) {
                    window.sendToFlutter('unity_ready', 'Unity WebGL canvas loaded and configured');
                    console.log('✅ unity_ready sent to Flutter');
                    unityReady = true;
                  } else {
                    console.error('❌ sendToFlutter function not available');
                  }
                }
              }, 1000);
              
              // 정기적으로 Unity 통신 테스트
              setTimeout(() => {
                console.log('🧪 Testing Unity communication...');
                if (window.sendToUnity('GameManager', 'RequestGameStatus', '')) {
                  console.log('✅ Unity communication test successful');
                } else {
                  console.warn('⚠️ Unity communication test failed, but will keep trying');
                  // 3초 후 다시 시도
                  setTimeout(() => {
                    console.log('🔄 Retrying Unity communication...');
                    window.sendToUnity('GameManager', 'RequestGameStatus', '');
                  }, 3000);
                }
              }, 2000);
            }
            
            // Unity 로드 확인 시작
            setTimeout(checkUnityLoaded, 1500);
          ''',
        );
        
        // Unity 준비 확인
        Future.delayed(const Duration(seconds: 2), () {
          _checkGameStatus();
        });
      },
      onProgressChanged: (controller, progress) => ref.game.setProgress(progress / 100),
      onReceivedError: (controller, request, error) => ref.game.setErrorMessage(error.description),
      shouldOverrideUrlLoading: (controller, navigationAction) async => NavigationActionPolicy.ALLOW,
    );
  }
}