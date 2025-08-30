import 'package:flutter/cupertino.dart';

extension ColoredTextSpan on String {
  TextSpan colored({
    required TextStyle baseStyle,
    required Color color,
  }) {
    return TextSpan(
      text: this,
      style: baseStyle.copyWith(color: color),
    );
  }
}