// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Jersey25-Regular.ttf
  String get jersey25Regular => 'assets/fonts/Jersey25-Regular.ttf';

  /// List of all assets
  List<String> get values => [jersey25Regular];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/ic_gochu_38x36@1x.png
  AssetGenImage get icGochu38x361x =>
      const AssetGenImage('assets/icons/ic_gochu_38x36@1x.png');

  /// File path: assets/icons/ic_gochu_38x36@2x.png
  AssetGenImage get icGochu38x362x =>
      const AssetGenImage('assets/icons/ic_gochu_38x36@2x.png');

  /// File path: assets/icons/ic_gochu_38x36@3x.png
  AssetGenImage get icGochu38x363x =>
      const AssetGenImage('assets/icons/ic_gochu_38x36@3x.png');

  /// File path: assets/icons/ic_kimchi_90x96@1x.png
  AssetGenImage get icKimchi90x961x =>
      const AssetGenImage('assets/icons/ic_kimchi_90x96@1x.png');

  /// File path: assets/icons/ic_kimchi_90x96@2x.png
  AssetGenImage get icKimchi90x962x =>
      const AssetGenImage('assets/icons/ic_kimchi_90x96@2x.png');

  /// File path: assets/icons/ic_kimchi_90x96@3x.png
  AssetGenImage get icKimchi90x963x =>
      const AssetGenImage('assets/icons/ic_kimchi_90x96@3x.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    icGochu38x361x,
    icGochu38x362x,
    icGochu38x363x,
    icKimchi90x961x,
    icKimchi90x962x,
    icKimchi90x963x,
  ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/bg_sky_320x180@1x.png
  AssetGenImage get bgSky320x1801x =>
      const AssetGenImage('assets/images/bg_sky_320x180@1x.png');

  /// File path: assets/images/bg_sky_320x180@2x.png
  AssetGenImage get bgSky320x1802x =>
      const AssetGenImage('assets/images/bg_sky_320x180@2x.png');

  /// File path: assets/images/bg_sky_320x180@3x.png
  AssetGenImage get bgSky320x1803x =>
      const AssetGenImage('assets/images/bg_sky_320x180@3x.png');

  /// File path: assets/images/btn_action_228x50@1x.png
  AssetGenImage get btnAction228x501x =>
      const AssetGenImage('assets/images/btn_action_228x50@1x.png');

  /// File path: assets/images/btn_action_228x50@2x.png
  AssetGenImage get btnAction228x502x =>
      const AssetGenImage('assets/images/btn_action_228x50@2x.png');

  /// File path: assets/images/btn_action_228x50@3x.png
  AssetGenImage get btnAction228x503x =>
      const AssetGenImage('assets/images/btn_action_228x50@3x.png');

  /// File path: assets/images/sprite_player_jump_192x64@1x.png
  AssetGenImage get spritePlayerJump192x641x =>
      const AssetGenImage('assets/images/sprite_player_jump_192x64@1x.png');

  /// File path: assets/images/sprite_player_jump_192x64@2x.png
  AssetGenImage get spritePlayerJump192x642x =>
      const AssetGenImage('assets/images/sprite_player_jump_192x64@2x.png');

  /// File path: assets/images/sprite_player_jump_192x64@3x.png
  AssetGenImage get spritePlayerJump192x643x =>
      const AssetGenImage('assets/images/sprite_player_jump_192x64@3x.png');

  /// File path: assets/images/title_kimchi_run_227x33@1x.png
  AssetGenImage get titleKimchiRun227x331x =>
      const AssetGenImage('assets/images/title_kimchi_run_227x33@1x.png');

  /// File path: assets/images/title_kimchi_run_227x33@2x.png
  AssetGenImage get titleKimchiRun227x332x =>
      const AssetGenImage('assets/images/title_kimchi_run_227x33@2x.png');

  /// File path: assets/images/title_kimchi_run_227x33@3x.png
  AssetGenImage get titleKimchiRun227x333x =>
      const AssetGenImage('assets/images/title_kimchi_run_227x33@3x.png');

  /// List of all assets
  List<AssetGenImage> get values => [
    bgSky320x1801x,
    bgSky320x1802x,
    bgSky320x1803x,
    btnAction228x501x,
    btnAction228x502x,
    btnAction228x503x,
    spritePlayerJump192x641x,
    spritePlayerJump192x642x,
    spritePlayerJump192x643x,
    titleKimchiRun227x331x,
    titleKimchiRun227x332x,
    titleKimchiRun227x333x,
  ];
}

class Assets {
  const Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
    this.animation,
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;
  final AssetGenImageAnimation? animation;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.medium,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({AssetBundle? bundle, String? package}) {
    return AssetImage(_assetName, bundle: bundle, package: package);
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class AssetGenImageAnimation {
  const AssetGenImageAnimation({
    required this.isAnimation,
    required this.duration,
    required this.frames,
  });

  final bool isAnimation;
  final Duration duration;
  final int frames;
}
