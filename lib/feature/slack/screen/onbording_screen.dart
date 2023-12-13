import 'package:flutter/material.dart';
import 'package:mapsuygulama/feature/login/components/log_in_components.dart';
import 'package:mapsuygulama/feature/login/components/sign_up_components.dart';
import 'package:mapsuygulama/feature/login/mixin/login_screen_page.dart';
import 'package:mapsuygulama/product/controller/localizations_checker.dart';
import 'package:mapsuygulama/feature/login/components/google_maps_widget.dart';
import 'package:mapsuygulama/feature/slack/component/onboard_content.dart';
import 'package:mapsuygulama/product/models/onboard_model.dart';

import '../component/indicator_widget.dart';
import 'package:easy_localization/easy_localization.dart';

 class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;

  int _pageIndex = 0;
  bool _isLoading = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  itemCount: data.length,
                  controller: _pageController,
                  onPageChanged: (value) {
                    setState(() {
                      _pageIndex = value;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          child: OnBoardContent(
                            imageUrl: data[index].image,
                            title: data[index].title.tr(),
                            descripton: data[index].description.tr(),
                          ),
                        ),
                        if (_pageIndex == 0)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.black,
                                    ),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      LocalizationChecker.changeLanguage(
                                          context);
                                    });
                                  },
                                  child: Text(
                                    'TR',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(width: 8),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.black),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      LocalizationChecker.changeLanguage(
                                          context);
                                    });
                                  },
                                  child: Text(
                                    'EN',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (_pageIndex == 0)
                          Row(
                            children: [
                              ...List.generate(
                                data.length,
                                (index) => Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child:
                                      Indicator(isActive: index == _pageIndex),
                                ),
                              ),
                              Spacer(),
                              SizedBox(
                                height: 60,
                                width: 60,
                                child: ElevatedButton(
                                  onPressed: () {
                                    _pageController.nextPage(
                                      curve: Curves.ease,
                                      duration: Duration(milliseconds: 500),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: CircleBorder(),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 0.0),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        if (_pageIndex != 0)
                          Row(
                            children: [
                              ...List.generate(
                                data.length,
                                (index) => Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child:
                                      Indicator(isActive: index == _pageIndex),
                                ),
                              ),
                              Spacer(),
                              _circularButton(context),
                            ],
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _circularButton(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: ElevatedButton(
        onPressed: () {
          if (_isLoading) {
            return;
          }

          if (_pageIndex == data.length - 1) {
            setState(() {
              _isLoading = true;
            });

            Future.delayed(Duration(seconds: 2), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginInComponent(),
                ),
              ).then((_) {
                setState(() {
                  _isLoading = false;
                });
              });
            });
          } else {
            _pageController.nextPage(
              curve: Curves.ease,
              duration: Duration(milliseconds: 300),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: CircleBorder(),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            if (!_isLoading)
              Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            if (_isLoading)
              SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

