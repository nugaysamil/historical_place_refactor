import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mapsuygulama/product/enums/locales_enum.dart';

@immutable

/// Product Localization Manager
final class ProductLocalization extends EasyLocalization {
  //// ProductLocalization need to [child] for a wrap locale items
  ProductLocalization({
    required super.child,
    super.key,
  }) : super(
          supportedLocales: _supportedLocales,
          path: _translationPath,
          useOnlyLangCode: true,
        );

  static final List<Locale> _supportedLocales = [
    Locales.tr.locale,
    Locales.en.locale,
  ];

  static const String _translationPath = 'assets/translations';
  //change project language by using [Locales]
  static Future<void> updateLanguage({
    required BuildContext context,
    required Locales value,
  }) =>
      context.setLocale(value.locale);
}
