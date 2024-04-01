// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:mapsuygulama/product/utils/const/string_const.dart';
import 'package:rive/rive.dart';

class MenuButton extends StatelessWidget {
  const MenuButton({
    Key? key,
    required this.press,
    required this.riveOnInit,
  }) : super(key: key);

  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: press,
        child: Container(
          margin: EdgeInsets.only(left: 16),
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 3),
                blurRadius: 8,
              ),
            ],
          ),
          child: RiveAnimation.asset(
            StringConstants.riveAssets,
            artboard: StringConstants.artBoardSettings,
            onInit: riveOnInit,
          ),
        ),
      ),
    );
  }
}
