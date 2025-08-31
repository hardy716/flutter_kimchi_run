import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';

class BackgroundScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget child;

  const BackgroundScaffold({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: appBar,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: Assets.images.bgSky320x1802x.provider(), fit: BoxFit.cover),
        ),
        child: child,
      ),
    );
  }
}
