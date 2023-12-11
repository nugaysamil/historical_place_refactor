// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapsuygulama/feature/login/components/sign_up_components.dart';
import 'package:mapsuygulama/feature/login/widgets/text_field/widget_text_field.dart';
import 'package:mapsuygulama/feature/repository/auth_google_service.dart';
import 'package:mapsuygulama/feature/repository/email_validator.dart';
import 'package:mapsuygulama/feature/profile/companenets/profile_edit.dart';
import 'package:mapsuygulama/feature/login/controller/login_controller.dart';
import 'package:mapsuygulama/feature/login/controller/login_state.dart';
import 'package:mapsuygulama/feature/google/custom_widget.dart';
import 'package:mapsuygulama/feature/login/widgets/or_divider.dart';
import 'package:mapsuygulama/product/utils/const/color_const.dart';
import '../widgets/text/widget_bottom_text.dart';
import '../widgets/text_field/widget_password_field.dart';
import '../widgets/text/widget_top_text.dart';

class LoginContent extends StatefulHookConsumerWidget {
  const LoginContent({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginContentState();
}

class _LoginContentState extends ConsumerState<LoginContent>
    with TickerProviderStateMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  void hideKeyboard() {
    final currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  Widget signUpButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          hideKeyboard();
          onPressed();
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: const StadiumBorder(),
          backgroundColor: kSecondaryColor,
          elevation: 8,
          shadowColor: Colors.black87,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

   Widget signInWithGoogleLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shadowColor: MaterialStateProperty.all(Colors.transparent),
            elevation: MaterialStateProperty.all(0),
          ),
          onPressed: () async {
            final userCredential = await AuthService().signInWithGoogle();

            if (userCredential != null) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEdit()),
              );
            }
          },
          child: Image.asset('assets/images/google.png'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<LoginState>(loginControllerProvider, ((previous, state) {
      if (state is LoginStateError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.error)));
      }
    }));
    return Stack(
      children: [
        Positioned(
          top: 136,
          left: 35,
          child: TopText(
            topText: 'create_account'.tr(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  InputTextField(
                      textController: _emailController,
                      hint: 'Email',
                      iconData: Ionicons.mail_outline),
                  PasswordInputField(
                      textController: _passwordController,
                      hint: 'password'.tr(),
                      iconData: Ionicons.lock_closed_outline),
                  PasswordInputField(
                      textController: _confirmController,
                      hint: 'confirm_password'.tr(),
                      iconData: Ionicons.refresh_outline),
                  signUpButton(
                    "sign_up".tr(),
                    () async {
                      if (_passwordController.text != _confirmController.text) {
                        ref.read(loginControllerProvider.notifier).state =
                            LoginStateError('Please enter email and password.');
                      } else {
                        final email = _emailController.text;
                        final password = _passwordController.text;
                        try {
                          final signInMethods =
                              await EmailValidator.fetchSignInMethodsForEmail(
                                  email);
                          if (signInMethods.isNotEmpty) {
                            ref.read(loginControllerProvider.notifier).state =
                                LoginStateError(
                                    'E-posta adresi zaten kullanımda.');
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
                    },
                  ),
                  Center(
                    child: BottomText(
                      text2: "without_membership".tr(),
                      onTapCallback: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CustomMarkerInfoWindow(),
                          ),
                        );
                      },
                    ),
                  ),
                  OrDivider(),
                  SizedBox(
                    height: 10,
                  ),
                  signInWithGoogleLogo(),
                ],
              ),
            ],
          ),
        ),
        alreadyAccount(context),
      ],
    );
  }

  Align alreadyAccount(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: BottomText(
          onTapCallback: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignUpComponents()),
            );
          },
          text: 'already_account'.tr(),
          text2: 'login_in'.tr(),
        ),
      ),
    );
  }
}
