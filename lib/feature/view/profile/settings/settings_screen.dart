import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mapsuygulama/feature/view/profile/settings/mixin/settings_screen_mixin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mapsuygulama/product/enums/locales_enum.dart';
import 'package:mapsuygulama/product/initialize/product_localization.dart';

class LanguageSelection extends StatefulWidget {
  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection>
    with SettingsScreenMixin {
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final prefs = await SharedPreferences.getInstance();
    final language = await loadSelectedLanguage(prefs);
    setState(() {
      selectedLanguage = language;
    });
  }

  void _updateLanguage(String language) {
    ProductLocalization.updateLanguage(
      context: context,
      value: Locales.values.firstWhere((e) => e.name == language),
    );
    setState(() {
      selectedLanguage = language;
    });
    _saveLanguage(language);
    showLanguageChangeDialog(context);
  }

  void _saveLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    saveSelectedLanguage(language, prefs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          RadioListTile(
            title: Text('Türkçe'),
            value: 'tr',
            groupValue: selectedLanguage,
            onChanged: (value) => _updateLanguage(value.toString()),
          ),
          SizedBox(height: 8),
          RadioListTile(
            title: Text('English'),
            value: 'en',
            groupValue: selectedLanguage,
            onChanged: (value) => _updateLanguage(value.toString()),
          ),
        ],
      ),
    );
  }
}

