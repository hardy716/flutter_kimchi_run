import 'package:flutter/material.dart';

import '../../../core/theme/app/app_texts.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/colors.gen.dart';

class ActionTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double height;
  final TextStyle textStyle;

  const ActionTextButton({
    super.key,
    required this.text,
    required this.onTap,
    this.height = 50.0,
    this.textStyle = AppTexts.h2,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Assets.images.btnAction228x503x.image(height: height),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              splashColor: ColorName.greenVibrant100.withAlpha(80),
              child: Center(child: Text(text, style: AppTexts.h2.copyWith(height: - 0.25))),
            ),
          ),
        ),
      ],
    );
  }
}
