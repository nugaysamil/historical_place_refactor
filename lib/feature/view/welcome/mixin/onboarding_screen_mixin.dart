

import 'package:flutter/widgets.dart';
import 'package:mapsuygulama/feature/view/welcome/screen/onbording_screen.dart';

mixin OnBoardingScreenMixin on State<OnBoardingScreen> {

    late PageController pageController;

  int pageIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

} 