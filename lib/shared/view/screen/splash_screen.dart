import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/theme/theme.dart';
import '../../../../../gen/colors.gen.dart';
import '../../../router/route_paths.dart';
import '../widgets/background_scaffold.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _dropController;
  late Animation<double> _dropAnimation;

  @override
  void initState() {
    super.initState();

    _dropController = AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _dropAnimation = Tween<double>(
      begin: -200,
      end: 0,
    ).animate(CurvedAnimation(parent: _dropController, curve: Curves.bounceOut));

    _dropController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        context.go(AppRoute.login.path);
      }
    });

    _dropController.forward();
  }

  @override
  void dispose() {
    _dropController.dispose();
    super.dispose();
  }

  Widget _buildAnimatedWord() {
    const word = 'KIMCHI RUN';
    const colorChangeIndex = 'KIMCHI'.length; // 6

    return AnimatedBuilder(
      animation: _dropAnimation,
      builder: (context, child) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(word.length, (i) {
          return Transform.translate(
            offset: Offset(0, _dropAnimation.value),
            child: Text(
              word[i],
              style: AppTexts.h2.copyWith(
                color: (i >= colorChangeIndex) ? ColorName.orangeVibrant100 : ColorName.black100,
                fontSize: 48,
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: SafeArea(child: Center(child: _buildAnimatedWord())),
    );
  }
}
