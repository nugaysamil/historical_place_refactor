import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mapsuygulama/feature/slack/screen/onbording_screen.dart';
import 'product/initialize/app_theme.dart';
import 'product/initialize/application_start.dart';

Future<void> main() async {
  await ApplicationStart.init();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('tr', 'TR')],
        fallbackLocale: Locale('tr', 'TR'),
        path: 'assets/translations',
        
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.getAppTheme(context),
        home: OnBordingScreen());
  }
}
