import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import '../shared/shared.dart' show SplashScreen, ErrorScreen;
import '../modules/auth/auth.dart' show LoginScreen;
import '../modules/game/game.dart' show GameScreen;
import '../modules/profile/profile.dart' show ProfileScreen;
import 'route_paths.dart';

final Map<AppRoute, Page<dynamic> Function(BuildContext, GoRouterState)> routeBuilders = {
  AppRoute.splash: (context, state) => _buildPage(context: context, state: state, child: const SplashScreen()),
  AppRoute.login: (context, state) => _buildPage(context: context, state: state, child: const LoginScreen()),
  AppRoute.game: (context, state) => _buildPage(context: context, state: state, child: const GameScreen()),
  AppRoute.profile: (context, state) => _buildPage(context: context, state: state, child: const ProfileScreen()),
  AppRoute.error: (context, state) => _buildPage(context: context, state: state, child: const ErrorScreen()),
};

CustomTransitionPage<dynamic> _buildPage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
        child: child,
      );
    },
  );
}

extension AppRouteBuilder on AppRoute {
  Page<dynamic> Function(BuildContext, GoRouterState) get builder {
    final builder = routeBuilders[this];
    if (builder != null) return builder;

    return (context, state) => _buildPage(context: context, state: state, child: const ErrorScreen());
  }
}