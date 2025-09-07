import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/theme/app/app_texts.dart';
import '../../../../../gen/colors.gen.dart';

class GameAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback onLogin;
  final VoidCallback onRanking;
  final bool isShow;

  const GameAppBar({super.key, required this.onLogin, required this.onRanking, required this.isShow});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Material(
      child: Container(
        height: kToolbarHeight,
        color: ColorName.skyBlue100,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: isShow
              ? [
                  InkWell(
                    splashColor: ColorName.yellowGold100,
                    onTap: onLogin,
                    child: Text('NICKNAME', style: AppTexts.b3.copyWith(decoration: TextDecoration.underline)),
                  ),

                  InkWell(
                    splashColor: ColorName.yellowGold100,
                    onTap: onRanking,
                    child: Text('RANKING', style: AppTexts.b3.copyWith(decoration: TextDecoration.underline)),
                  ),
                ]
              : [],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
