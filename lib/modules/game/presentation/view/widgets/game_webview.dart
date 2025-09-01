import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_kimchi_run/core/constants/default_constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/app_constants.dart';
import '../game_provider.dart';

class GameWebView extends ConsumerStatefulWidget {
  const GameWebView({super.key});

  @override
  ConsumerState<GameWebView> createState() => _GameWebViewState();
}

class _GameWebViewState extends ConsumerState<GameWebView> {
  InAppWebViewController? webViewController;

  @override
  void initState() {
    super.initState();
    ref.read(gameStateProvider).startPlayTimeTimer();
  }

  void _handleUnityMessage(String message) {
    try {
      final data = jsonDecode(message);
      final String type = data['type'] ?? '';
      final dynamic payload = data['data'];

      final notifier = ref.read(gameStateProvider);

      switch (type) {
        case 'unity_ready':
          notifier.setUnityReady(true);
          // showSnackBar
          break;
        case 'score_update':
          notifier.updateScore(int.tryParse(payload.toString()) ?? 0);
          break;
        case 'level_complete':
          notifier.updateLevel(int.tryParse(payload.toString()) ?? 1);
          // showSnackBar
          break;
        case 'game_over':
          notifier.pauseGame();
          // showGameOverDialog
          break;
      }
    } catch (e) {
      debugPrint('Unity 메시지 처리 오류: $e');
    }
  }

  void sendToUnity(String gameObject, String method, String parameter) {
    webViewController?.evaluateJavascript(
      source: '''
        if (typeof window.sendToUnity === 'function') {
          window.sendToUnity('$gameObject', '$method', '$parameter');
        } else {
          console.warn('Unity communication not ready');
        }
      ''',
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(gameStateProvider, (previousState, newState) {
      if (previousState?.isPaused != newState.isPaused) {
        if (newState.isPaused) {
          sendToUnity('GameManager', 'PauseGame', '');
        } else {
          sendToUnity('GameManager', 'ResumeGame', '');
        }
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
      ),
      onWebViewCreated: (controller) {
        webViewController = controller;
        controller.addJavaScriptHandler(
          handlerName: 'FlutterUnityBridge',
          callback: (args) {
            if (args.isNotEmpty) {
              _handleUnityMessage(args[0].toString());
            }
          },
        );
      },
      onLoadStart: (controller, url) => ref.read(gameStateProvider).setLoading(true),
      onLoadStop: (controller, url) async {
        ref.read(gameStateProvider).setLoading(false);
        await controller.evaluateJavascript(
          source: '''
            window.sendToFlutter = function(type, data) {
              const message = JSON.stringify({type: type, data: data});
              window.flutter_inappwebview.callHandler('FlutterUnityBridge', message);
            };
            window.sendToUnity = function(gameObject, method, parameter) {
              if (typeof unityInstance !== 'undefined' && unityInstance) {
                unityInstance.SendMessage(gameObject, method, parameter);
                return true;
              }
              return false;
            };
            let checkUnity = setInterval(() => {
              if (typeof unityInstance !== 'undefined' && unityInstance) {
                clearInterval(checkUnity);
                sendToFlutter('unity_ready', 'Unity is ready');
              }
            }, 500);
            setTimeout(() => clearInterval(checkUnity), 30000);
          ''',
        );
      },
      onProgressChanged: (controller, progress) => ref.read(gameStateProvider).setProgress(progress / 100),
      onReceivedError: (controller, request, error) => ref.read(gameStateProvider).setErrorMessage(error.description),
      shouldOverrideUrlLoading: (controller, navigationAction) async => NavigationActionPolicy.ALLOW,
    );
  }
}