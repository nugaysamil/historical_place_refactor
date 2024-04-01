import 'package:flutter/material.dart';

import '../utils/const/color_const.dart';

class AppTheme {
  static ThemeData getAppTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: false,
      scaffoldBackgroundColor: Colors.white,
      textTheme: Theme.of(context).textTheme.apply(
            bodyColor: ProjectColors().kPrimaryColor,
            fontFamily: 'Poppins',
            displayColor: Colors.transparent,
          ),
    );
  }
}
