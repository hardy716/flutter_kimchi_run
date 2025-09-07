import 'package:flutter/material.dart';

import '../../../gen/colors.gen.dart';

class SeparatorDivider extends StatelessWidget {
  const SeparatorDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(color: ColorName.white100.withAlpha(60), height: 0.5, thickness: 0.5);
  }
}
