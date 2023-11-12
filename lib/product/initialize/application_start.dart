import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import '../helper/firebase_options.dart';

@immutable
final class ApplicationStart {
  const ApplicationStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      name: 'newhistorical-b4f75',
      options: DefaultFirebaseOptions.currentPlatform,
    );

    EasyLocalization.logger.enableLevels = [LevelMessages.error];

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await EasyLocalization.ensureInitialized();
  }
}
