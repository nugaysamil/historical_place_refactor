import 'package:flutter/material.dart';

import '../utils/constants.dart';

class AppTheme {
  static ThemeData getAppTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: kBackgroundColor,
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: kPrimaryColor,
            fontFamily: 'Montserrat',
          ),
    );
  }
}