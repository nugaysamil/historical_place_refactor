import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

mixin SettingsScreenMixin {
  void saveSelectedLanguage(String language, SharedPreferences prefs) {
    prefs.setString('selectedLanguage', language);
  }

  Future<String?> loadSelectedLanguage(SharedPreferences prefs) async {
    return prefs.getString('selectedLanguage') ?? 'tr';
  }

  void showLanguageChangeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('language_change'.tr()),
          content: Text('language_change_description'.tr()),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('continue'.tr()),
            ),
          ],
        );
      },
    );
  }
}
