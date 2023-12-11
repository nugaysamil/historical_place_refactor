import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mapsuygulama/feature/google/custom_widget.dart';
import 'package:mapsuygulama/feature/login/controller/auth_checker.dart';
import 'package:mapsuygulama/feature/profile/companenets/profile_edit.dart';
import 'package:mapsuygulama/feature/profile/profile_update/profile_update_widget.dart';
import 'package:mapsuygulama/feature/slack/screen/onbording_screen.dart';
import 'package:mapsuygulama/product/initialize/product_localization.dart';
import 'product/initialize/app_theme.dart';
import 'product/initialize/application_start.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(
    ProviderScope(
        child: ProductLocalization(
      child: const MyApp(),
    )),
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
        home: ProfileEditUpdate()); 
  }
}
