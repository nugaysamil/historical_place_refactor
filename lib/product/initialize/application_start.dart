import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import '../helper/firebase_options.dart';


// Project initialization
@immutable
final class ApplicationStart {
  const ApplicationStart._();
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Project Firebase initialization
    await Firebase.initializeApp(

      options: DefaultFirebaseOptions.currentPlatform,
    );

    EasyLocalization.logger.enableLevels = [LevelMessages.error];

    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    await EasyLocalization.ensureInitialized();
  }
}
