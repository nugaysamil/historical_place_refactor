import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mapsuygulama/feature/slack/screen/onbording_screen.dart';
import 'package:mapsuygulama/product/data_provider/auth_provider.dart';
import 'package:mapsuygulama/feature/google/custom_widget.dart';


class AuthChecker extends ConsumerWidget {
  const AuthChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final _authState = ref.watch(authStateProvider);

    return _authState.when(
      data: (user) {
        if (user != null) {
          return CustomMarkerInfoWindow();
        } else {
          return OnBoardingScreen();
        }
      },
      error: (e, trace) => const OnBoardingScreen(),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
