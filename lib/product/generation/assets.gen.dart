/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsRiveAssetsGen {
  const $AssetsRiveAssetsGen();

  /// File path: assets/RiveAssets/icons.riv
  String get icons => 'assets/RiveAssets/icons.riv';

  /// File path: assets/RiveAssets/icons2.riv
  String get icons2 => 'assets/RiveAssets/icons2.riv';

  /// File path: assets/RiveAssets/menu.riv
  String get menu => 'assets/RiveAssets/menu.riv';

  /// File path: assets/RiveAssets/menuitems.riv
  String get menuitems => 'assets/RiveAssets/menuitems.riv';

  /// List of all assets
  List<String> get values => [icons, icons2, menu, menuitems];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/facebook.png
  AssetGenImage get facebook =>
      const AssetGenImage('assets/images/facebook.png');

  /// File path: assets/images/foursquare.png
  AssetGenImage get foursquare =>
      const AssetGenImage('assets/images/foursquare.png');

  /// File path: assets/images/google.png
  AssetGenImage get google => const AssetGenImage('assets/images/google.png');

  /// File path: assets/images/histo.jpeg
  AssetGenImage get histo => const AssetGenImage('assets/images/histo.jpeg');

  /// File path: assets/images/tripadvisor.jpg
  AssetGenImage get tripadvisor =>
      const AssetGenImage('assets/images/tripadvisor.jpg');

  /// File path: assets/images/user.png
  AssetGenImage get user => const AssetGenImage('assets/images/user.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [facebook, foursquare, google, histo, tripadvisor, user];
}

class $AssetsMapthemeGen {
  const $AssetsMapthemeGen();

  /// File path: assets/maptheme/aubergine_theme.json
  String get aubergineTheme => 'assets/maptheme/aubergine_theme.json';

  /// File path: assets/maptheme/dark_theme.json
  String get darkTheme => 'assets/maptheme/dark_theme.json';

  /// List of all assets
  List<String> get values => [aubergineTheme, darkTheme];
}

class $AssetsTranslationsGen {
  const $AssetsTranslationsGen();

  /// File path: assets/translations/en-US.json
  String get enUS => 'assets/translations/en-US.json';

  /// File path: assets/translations/tr-TR.json
  String get trTR => 'assets/translations/tr-TR.json';

  /// List of all assets
  List<String> get values => [enUS, trTR];
}

class Assets {
  Assets._();

  static const $AssetsRiveAssetsGen riveAssets = $AssetsRiveAssetsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsMapthemeGen maptheme = $AssetsMapthemeGen();
  static const $AssetsTranslationsGen translations = $AssetsTranslationsGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

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
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
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

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
