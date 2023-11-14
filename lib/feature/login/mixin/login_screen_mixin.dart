import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:mapsuygulama/feature/login/controller/login_controller.dart';
import 'package:mapsuygulama/feature/login/controller/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapsuygulama/feature/profile/companenets/profile_edit.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';

part of "../mixin/login_screen_page.dart";

mixin _CustomLoginButtonMixin on ConsumerState<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  Future<void> handleButton() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ref.read(loginControllerProvider.notifier).state =
          LoginStateError('Please enter email and password.');
    } else {
      try {
        final email = _emailController.text;
        final password = _passwordController.text;

        final methods =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

        if (methods.isNotEmpty) {
          await ref
              .read(loginControllerProvider.notifier)
              .userLogin(email, password);

          Fluttertoast.showToast(
            msg: msgLogInSucces,
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
        } else {
          ref.read(loginControllerProvider.notifier).state =
              LoginStateError('Böyle bir email bulunamadı.');
        }
      } catch (e) {
        ref.read(loginControllerProvider.notifier).state =
            LoginStateError('Invalid email or password.');
      }
    }
  }
}
