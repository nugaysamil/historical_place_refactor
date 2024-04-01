import 'package:flutter/material.dart';
import 'package:mapsuygulama/feature/view/profile/profile_update/profile_update_widget.dart';
import 'package:mapsuygulama/feature/view/profile/settings/settings_screen.dart';
import 'package:mapsuygulama/feature/view/side_menu/widget/favorite_widget.dart';
import 'package:mapsuygulama/feature/view/google/custom_widget.dart';
import 'package:mapsuygulama/feature/view/welcome/screen/onbording_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


mixin SideMenuMixin {
  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => OnBoardingScreen()),
    );
  }

  void navigateToProfile(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileEditUpdate()),
    );
  }

  void navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CustomMarkerInfoWindow()),
    );
  }

  void navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LanguageSelection()),
    );
  }

  void navigateToFavorites(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FavWidget()),
    );
  }
}
