import 'package:flutter/material.dart' show GlobalKey, NavigatorState;

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'route_page_builder.dart';
import 'route_paths.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final navigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root-navigator');
  // final shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell-navigator');

  final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: AppRoute.ranking.path,
    // refreshListenable: ,
    // redirect: ,
    routes: [
      GoRoute(path: AppRoute.splash.path, name: AppRoute.splash.name, pageBuilder: AppRoute.splash.builder),
      GoRoute(path: AppRoute.login.path, name: AppRoute.login.name, pageBuilder: AppRoute.login.builder),
      GoRoute(path: AppRoute.game.path, name: AppRoute.game.name, pageBuilder: AppRoute.game.builder),
      GoRoute(path: AppRoute.ranking.path, name: AppRoute.ranking.name, pageBuilder: AppRoute.ranking.builder),
      GoRoute(path: AppRoute.error.path, name: AppRoute.error.name, pageBuilder: AppRoute.error.builder),
    ],
    errorPageBuilder: AppRoute.error.builder,
  );

  ref.onDispose(router.dispose);

  return router;
}