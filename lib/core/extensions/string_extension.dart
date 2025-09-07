import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';

extension Sha256EncodingExtension on String {
  String toSha256() {
    final bytes = utf8.encode(this);

    final Digest hash = sha256.convert(bytes);

    return hash.toString();
  }
}

extension NullableOrEmptyStringExtension on String? {
  String orPlaceholder(String? placeHolder) {
    return (this != null && this?.isNotEmpty == true) ? this! : (placeHolder ?? '');
  }
}

extension TextSpanStylingExtension on String {
  TextSpan colored({TextStyle? baseStyle, int leadingSpaces = 0, int trailingSpaces = 0}) {
    return TextSpan(text: ' ' * leadingSpaces + this + ' ' * trailingSpaces, style: baseStyle);
  }
}
