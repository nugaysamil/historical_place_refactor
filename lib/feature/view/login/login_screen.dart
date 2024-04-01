// ignore_for_file: invalid_use_of_protected_member, unused_local_variable

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapsuygulama/feature/view/base/sign_in_components.dart';
import 'package:mapsuygulama/feature/view/signin/widgets/text_field/widget_text_field.dart';
import 'package:mapsuygulama/feature/controller/login_controller.dart';
import 'package:mapsuygulama/feature/controller/login_state.dart';
import 'package:mapsuygulama/feature/view/profile/widget/profile_edit.dart';
import 'package:mapsuygulama/product/utils/const/color_const.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';

import '../signin/widgets/text/widget_bottom_text.dart';
import '../signin/widgets/text_field/widget_password_field.dart';
import '../signin/widgets/text/widget_top_text.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'mixin/login_screen_mixin.dart';

class LogInPage extends StatefulHookConsumerWidget {
  const LogInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginContentState();
}

class _LoginContentState extends ConsumerState<LogInPage>
    with LoginScreenMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 136,
          left: 24,
          child: TopText(
            topText: StringConstants.welcomeBack.tr(),
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
                    hint: StringConstants.email.tr(),
                    iconData: Ionicons.mail_outline,
                  ),
                  PasswordInputField(
                    textController: _passwordController,
                    hint: StringConstants.password.tr(),
                    iconData: Ionicons.lock_closed_outline,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 135,
                      vertical: 16,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        loginInButton(context, ref);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: const StadiumBorder(),
                        backgroundColor: ProjectColors().kSecondaryColor,
                        elevation: 8,
                        shadowColor: Colors.black87,
                      ),
                      child: Text(
                        "sign_up".tr(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  forgotPassword(),
                ],
              ),
            ],
          ),
        ),
        _textAlign(context),
      ],
    );
  }

  Widget forgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 110),
      child: TextButton(
        onPressed: () {},
        child: Text(
          StringConstants.forgotPasswordText.tr(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ProjectColors().kSecondaryColor,
          ),
        ),
      ),
    );
  }

  Align _textAlign(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: BottomText(
          onTapCallback: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginInComponent()),
            );
          },
          text2: "log_in".tr(),
          text: StringConstants.dontAccount.tr(),
        ),
      ),
    );
  }
}
