import 'dart:ui';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'gen/assets.gen.dart';

Future<void> main() async {
  runZonedGuarded(
    () async {
      // Flutter 프레임워크 초기화 보장
      WidgetsFlutterBinding.ensureInitialized();

      // Firebase 초기화 및 Crashlytics 셋업
      await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      // 앱 화면 방향 가로 모드로 고정
      await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

      runApp(const MyApp());
    },
    (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage(), debugShowCheckedModeBanner: false);
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(child: Assets.images.bgSky320x1803x.image(fit: BoxFit.cover));
  }
}
