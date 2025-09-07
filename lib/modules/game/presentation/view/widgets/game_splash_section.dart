import 'package:flutter/material.dart';
import 'package:flutter_kimchi_run/shared/shared.dart';

import '../../../../../core/theme/app/app_texts.dart';
import '../../../../../gen/assets.gen.dart';
import '../../../../../gen/colors.gen.dart';

class GameSplashSection extends StatefulWidget {
  final double progress;
  final bool isUnityReady;
  
  const GameSplashSection({super.key, required this.progress, required this.isUnityReady});

  @override
  State<GameSplashSection> createState() => _GameSplashSectionState();
}

class _GameSplashSectionState extends State<GameSplashSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _revealAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    );
    _revealAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScaffold(
      child: Column(
        children: [
          // Top section with title
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [
                AnimatedBuilder(
                  animation: _revealAnimation,
                  builder: (context, child) {
                    return ClipRect(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        widthFactor: _revealAnimation.value,
                        child: Assets.images.spritePlayerJump192x641x.image(),
                      ),
                    );
                  },
                ),
                Text(
                  'Loading...',
                  style: AppTexts.b2.copyWith(color: ColorName.darkBlue100),
                ),
              ],
            ),
          ),

          // Bottom section with progress
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                  child: Column(
                    children: [
                      LinearProgressIndicator(
                        value: widget.progress,
                        backgroundColor: ColorName.white100.withValues(alpha: 0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(ColorName.orangeVibrant100),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.isUnityReady ? 'Preparing game...' : '${(widget.progress * 100).toInt()}%',
                        style: AppTexts.b4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}