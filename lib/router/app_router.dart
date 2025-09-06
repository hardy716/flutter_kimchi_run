import 'package:flutter/material.dart' show GlobalKey, NavigatorState, ValueNotifier;
import 'package:flutter_kimchi_run/modules/ranking/presentation/view_model/ranking_view_model.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../modules/auth/presentation/view_model/auth_view_model.dart';
import '../modules/auth/presentation/state/auth_state.dart';
import 'route_page_builder.dart';
import 'route_paths.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final appRouteNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root-navigator');

  final authValueNotifier = ValueNotifier<AsyncValue<AuthState>>(const AsyncLoading());

  ref
    ..onDispose(authValueNotifier.dispose)
    ..listen(authViewModelProvider.select((value) => value.whenData((value) => value)), (_, next) async {
      authValueNotifier.value = next;
    });
  final router = GoRouter(
    navigatorKey: appRouteNavigatorKey,
    initialLocation: AppRoute.splash.path,
    refreshListenable: authValueNotifier,
    redirect: (context, state) {
      if (state.uri.path == AppRoute.splash.path) {
        ref.read(rankingViewModelProvider.notifier).fetchRankingUser();
      }

      final authAsync = authValueNotifier.value;

      if (authAsync.isLoading || !authAsync.hasValue) return null;
      if (authAsync.unwrapPrevious().hasError) return AppRoute.login.path;

      final authState = authAsync.requireValue;

      final isLoginRoute = state.uri.path == AppRoute.login.path;
      final isAuthenticated = authState is AuthSuccess;

      print('isLoginRoute => $isLoginRoute');
      print('isAuthenticated => $isAuthenticated');

      if (isLoginRoute && isAuthenticated) {
        return AppRoute.game.path;
      }

      if (authState is AuthIdle && !isAuthenticated) {
        return AppRoute.login.path;
      }

      return null;
    },
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