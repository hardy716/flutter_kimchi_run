import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_kimchi_run/modules/ranking/presentation/view_model/ranking_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/default_constants.dart';
import '../game_provider.dart';

class GameWebView extends ConsumerStatefulWidget {
  const GameWebView({super.key});

  @override
  ConsumerState<GameWebView> createState() => GameWebViewState();
}

// GameWebView의 메소드에 접근하기 위한 전역 키
final GlobalKey<GameWebViewState> gameWebViewKey = GlobalKey<GameWebViewState>();

class GameWebViewState extends ConsumerState<GameWebView> {
  InAppWebViewController? webViewController;

  void _handleUnityMessage(String message) {
    try {
      final data = jsonDecode(message);
      final String type = data['type'] ?? '';
      final dynamic payload = data['data'];

      final notifier = ref.read(gameStateProvider);

      switch (type) {
        case 'unity_ready':
          notifier.setUnityReady(true);
          debugPrint('🎮 Unity is ready!');
          break;
        case 'game_started':
        case 'game_playing':
          notifier.startGame();
          debugPrint('🎮 Game started/playing from Unity');
          break;
        case 'game_ready':
          // Unity가 시작 상태임을 알림 (게임 시작 가능)
          debugPrint('🎮 Unity game is ready to start');
          break;
        case 'game_ended':
        case 'game_over':
        case 'game_finished':
          notifier.pauseGame();
          debugPrint('🎮 Game ended/over/finished from Unity');
          break;
        case 'game_paused':
          notifier.pauseGame();
          debugPrint('🎮 Game paused from Unity');
          break;
        case 'game_resumed':
          if (!notifier.isGameStarted) {
            notifier.startGame();
          } else {
            notifier.resumeGame();
          }
          debugPrint('🎮 Game resumed from Unity');
          break;
        case 'score_update':
          notifier.updateScore(int.tryParse(payload.toString()) ?? 0);
          debugPrint('📊 Score updated: ${payload}');
          break;
        case 'level_complete':
          notifier.updateLevel(int.tryParse(payload.toString()) ?? 1);
          debugPrint('🎯 Level completed: ${payload}');
          break;
        case 'unity_game_score':
          // 가이드에 따른 점수 전송 처리
          if (payload is Map) {
            final newScore = payload['newScore'] ?? 0;
            final highScore = payload['highScore'] ?? 0;
            notifier.updateScore(newScore);
            notifier.pauseGame(); // 게임 종료로 간주
            debugPrint('🏆 Final Score - New: $newScore, High: $highScore');
          }
          break;
      }
    } catch (e) {
      debugPrint('Unity 메시지 처리 오류: $e');
    }
  }

  void _pauseResumeGame(bool isPaused) {
    if (webViewController != null) {
      final method = isPaused ? 'PauseGame' : 'ResumeGame';
      webViewController!.evaluateJavascript(
        source: '''
          if (typeof window.sendToUnity === 'function') {
            window.sendToUnity('GameManager', '$method', '');
          } else {
            console.warn('Unity communication not ready for $method');
          }
        ''',
      );
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
    final gameState = ref.watch(gameStateProvider);
    
    ref.listen(gameStateProvider, (previousState, newState) {
      if (previousState?.isPaused != newState.isPaused) {
        _pauseResumeGame(newState.isPaused);
      }
      
      // Unity 준비 완료 시 게임 상태 확인
      if (newState.isUnityReady && (previousState?.isUnityReady != true)) {
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
        // 게임 시작 상태에 따른 터치 이벤트 제어 (JavaScript로 처리)
        allowsLinkPreview: false,
        allowsBackForwardNavigationGestures: false,
      ),
      onWebViewCreated: (controller) {
        webViewController = controller;
        
        // 가이드에 따른 Unity 메시지 핸들러 등록
        controller.addJavaScriptHandler(
          handlerName: 'FlutterUnityBridge',
          callback: (args) {
            if (args.isNotEmpty) {
              _handleUnityMessage(args[0].toString());
            }
          },
        );

        // 점수 수신 핸들러 (Unity에서 게임 종료 시 호출)
        controller.addJavaScriptHandler(
          handlerName: 'receiveGameScore',
          callback: (args) {
            if (args.isNotEmpty) {
              try {
                final scoreData = args[0] as Map<String, dynamic>;
                final newScore = scoreData['newScore'] ?? 0;
                final highScore = scoreData['highScore'] ?? 0;
                
                // 게임 상태 업데이트
                final notifier = ref.read(gameStateProvider);
                notifier.updateScore(newScore);
                notifier.pauseGame(); // 게임 오버 상태로 설정
                
                debugPrint('🎮 Game Over! Scores received from Unity:');
                debugPrint('   New Score: $newScore');
                debugPrint('   High Score: $highScore');

                ref.ranking.updateRankingUer(newScore: newScore);
                

              } catch (e) {
                debugPrint('❌ Score handling error: $e');
              }
            }
          },
        );
      },
      onLoadStart: (controller, url) => ref.read(gameStateProvider).setLoading(true),
      onLoadStop: (controller, url) async {
        ref.read(gameStateProvider).setLoading(false);
        
        // 가이드에 따른 해상도 설정 및 Unity 통신 초기화
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
      onProgressChanged: (controller, progress) => ref.read(gameStateProvider).setProgress(progress / 100),
      onReceivedError: (controller, request, error) => ref.read(gameStateProvider).setErrorMessage(error.description),
      shouldOverrideUrlLoading: (controller, navigationAction) async => NavigationActionPolicy.ALLOW,
    );
  }
}