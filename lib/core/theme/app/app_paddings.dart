import 'package:flutter/cupertino.dart';

class AppPaddings {
  static const EdgeInsetsGeometry screenPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
  static const EdgeInsetsGeometry appBarPadding = EdgeInsets.symmetric(horizontal: 30);

  // SECTION
  static const EdgeInsetsGeometry gameLoginSectionOuterPadding = EdgeInsets.only(left: 80, right: 80, bottom: 20);
  static const EdgeInsetsGeometry gameRankingSectionOuterPadding = EdgeInsets.only(left: 80, top: 10, right: 80, bottom: 30);

  // Etc.
  static const EdgeInsetsGeometry symmetricV20 = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsetsGeometry symmetricH30 = EdgeInsets.symmetric(horizontal: 30);
  static const EdgeInsetsGeometry symmetricH60 = EdgeInsets.symmetric(horizontal: 60);
  static const EdgeInsetsGeometry symmetricH20V10 = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
}