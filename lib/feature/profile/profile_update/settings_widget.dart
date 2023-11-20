import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mapsuygulama/product/enums/locales_enum.dart';
import 'package:mapsuygulama/product/initialize/product_localization.dart';

class LanguageSelection extends StatefulWidget {
  @override
  _LanguageSelectionState createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection> {
  String? selectedLanguage;

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  void _loadSelectedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedLanguage = prefs.getString('selectedLanguage') ?? 'tr';
    });
  }

  void _saveSelectedLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('selectedLanguage', language);
  }

  void _showLanguageChangeDialog(String selectedLanguage) {
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
            onChanged: (value) {
              ProductLocalization.updateLanguage(
                context: context,
                value: Locales.tr,
              );
              _saveSelectedLanguage(value.toString());
              _showLanguageChangeDialog(value.toString());
              setState(() {
                selectedLanguage = value.toString();
              });
            },
          ),
          SizedBox(height: 8),
          RadioListTile(
            title: Text('English'),
            value: 'en',
            groupValue: selectedLanguage,
            onChanged: (value) {
              ProductLocalization.updateLanguage(
                context: context,
                value: Locales.en,
              );
              _saveSelectedLanguage(value.toString());
              _showLanguageChangeDialog(value.toString());
              setState(() {
                selectedLanguage = value.toString();
              });
            },
          ),
        ],
      ),
    );
  }
}
