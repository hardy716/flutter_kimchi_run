import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:crypto/crypto.dart';

extension Sha256EncodingExtension on String {
  String toSha256() {
    final bytes = utf8.encode(this);

    final Digest hash = sha256.convert(bytes);

    return hash.toString();
  }
}

extension TextSpanStylingExtension on String {
  TextSpan colored({required TextStyle baseStyle, required Color color}) {
    return TextSpan(
      text: this,
      style: baseStyle.copyWith(color: color),
    );
  }
}
