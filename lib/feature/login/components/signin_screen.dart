// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mapsuygulama/feature/base/log_in_components.dart';
import 'package:mapsuygulama/feature/login/components/sigin_view_model.dart';
import 'package:mapsuygulama/feature/login/components/signin_mixin.dart';
import 'package:mapsuygulama/feature/login/widgets/text_field/widget_text_field.dart';
import 'package:mapsuygulama/feature/google/custom_widget.dart';
import 'package:mapsuygulama/feature/login/widgets/or_divider.dart';
import 'package:mapsuygulama/product/generation/assets.gen.dart';
import 'package:mapsuygulama/product/utils/const/color_const.dart';
import '../widgets/text/widget_bottom_text.dart';
import '../widgets/text_field/widget_password_field.dart';
import '../widgets/text/widget_top_text.dart';

class SignInPage extends StatefulHookConsumerWidget {
  const SignInPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInState();
}

class _SignInState extends ConsumerState<SignInPage>
    with TickerProviderStateMixin, SignInScreenMixin {
  final signInViewModel = SignInViewModel();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  child: TopText(
                    topText: 'create_account'.tr(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InputTextField(
                    textController: signInViewModel.emailController,
                    hint: 'Email',
                    iconData: Ionicons.mail_outline),
                PasswordInputField(
                    textController: signInViewModel.passwordController,
                    hint: 'password'.tr(),
                    iconData: Ionicons.lock_closed_outline),
                PasswordInputField(
                    textController: signInViewModel.confirmController,
                    hint: 'confirm_password'.tr(),
                    iconData: Ionicons.refresh_outline),
                signUpButton(
                  "log_in".tr(),
                  () async => signInViewModel.signUp(context, ref),
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
              MaterialPageRoute(builder: (context) => LogInComponents()),
            );
          },
          text: 'already_account'.tr(),
          text2: "sign_up".tr(),
        ),
      ),
    );
  }

  Widget signUpButton(String title, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 135, vertical: 16),
      child: ElevatedButton(
        onPressed: () {
          hideKeyboard(context);
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
          onPressed: () => signInViewModel.signInWithGoogle(context),
          child: Image.asset(Assets.images.google.path),
        ),
      ],
    );
  }
}
