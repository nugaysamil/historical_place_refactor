// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapsuygulama/feature/login/controller/login_controller.dart';
import 'package:mapsuygulama/feature/login/controller/login_state.dart';
import 'package:mapsuygulama/feature/profile/companenets/profile_edit.dart';
import 'package:mapsuygulama/feature/repository/auth_google_service.dart';
import 'package:mapsuygulama/feature/repository/email_validator.dart';

class SignInViewModel extends ChangeNotifier {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmController => _confirmController;

  Future<void> signInWithGoogle(BuildContext context) async {
    final userCredential = await AuthService().signInWithGoogle();
    if (userCredential != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileEdit()));
    } else {
      print('Error signing in with Google');
    }
  }

  Future<void> signUp(BuildContext context, WidgetRef ref) async {
    if (_passwordController.text != _confirmController.text) {
      ref.read(loginControllerProvider.notifier).state =
          LoginStateError('Please enter email and password.');
    } else {
      final email = _emailController.text;
      final password = _passwordController.text;
      try {
        final signInMethods =
            await EmailValidator.fetchSignInMethodsForEmail(email);
        if (signInMethods.isNotEmpty) {
          ref.read(loginControllerProvider.notifier).state =
              LoginStateError('E-posta adresi zaten kullanımda.');
        } else {
          ref
              .read(loginControllerProvider.notifier)
              .createUser(email, password);
          Fluttertoast.showToast(
            msg: "sign_up_correct".tr(),
            toastLength: Toast.LENGTH_SHORT,
          );
          Future.delayed(
            Duration(milliseconds: 700),
            () {
              _emailController.clear();
              _passwordController.clear();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileEdit(),
                ),
              );
            },
          );
        }
      } catch (error) {
        ref.read(loginControllerProvider.notifier).state =
            LoginStateError(error.toString());
      }
    }
  }
}
