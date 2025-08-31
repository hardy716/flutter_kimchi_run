import 'package:flutter/cupertino.dart';

class ExpandedAlign extends StatelessWidget {
  final int flex;
  final Alignment alignment;
  final Widget child;

  const ExpandedAlign({super.key, this.flex = 1, this.alignment = Alignment.center, required this.child});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Align(alignment: alignment, child: child),
    );
  }
}
