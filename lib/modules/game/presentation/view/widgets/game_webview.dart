import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/constants/default_constants.dart';
import '../../../data/handler/unity_message_handler.dart';
import '../../../data/handler/unity_webview_scripts.dart';
import '../../view_model/game_view_model.dart';

class GameWebView extends ConsumerStatefulWidget {
  const GameWebView({super.key});

  @override
  ConsumerState<GameWebView> createState() => GameWebViewState();
}

final GlobalKey<GameWebViewState> gameWebViewKey = GlobalKey<GameWebViewState>();

class GameWebViewState extends ConsumerState<GameWebView> {
  InAppWebViewController? webViewController;
  late UnityMessageHandler _messageHandler;

  @override
  void initState() {
    super.initState();
    _messageHandler = UnityMessageHandler(ref);
  }

  // Unity에 게임 상태 확인 메시지 전송
  void _checkGameStatus() {
    if (webViewController != null) {
      webViewController!.evaluateJavascript(
        source: UnityWebViewScripts.checkGameStatus,
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
              _messageHandler.handleMessage(args[0].toString());
            }
          },
        );
      },
      onLoadStart: (controller, url) => ref.game.setLoading(true),
      onLoadStop: (controller, url) async {
        ref.game.setLoading(false);
        
        await controller.evaluateJavascript(
          source: UnityWebViewScripts.fullInitScript,
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