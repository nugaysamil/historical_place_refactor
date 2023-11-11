import 'package:flutter/material.dart';

import 'dart:math' as math;

import '../widgets/center_widget.dart/center_widget.dart';
import 'sign_up_page.dart';

class LoginScreenComponents extends StatefulWidget {
  const LoginScreenComponents({super.key});

  @override
  State<LoginScreenComponents> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreenComponents> {
  Widget topWidget(double screenWidth) {
    return Transform.rotate(
      angle: -35 * math.pi / 180,
      child: Container(
        width: 1.2 * screenWidth,
        height: 1.2 * screenWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          gradient: LinearGradient(
            begin: Alignment(-0.2, -0.8),
            end: Alignment.bottomCenter,
            colors: [Colors.white70, Color.fromARGB(179, 244, 241, 241)],
          ),
        ),
      ),
    );
  }

  Widget bottomWidget(double screenWidth) {
    return Container(
      width: 3.0 * screenWidth,
      height: 3.0 * screenWidth,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment(0.6, -1.1),
          end: Alignment(0.7, 0.8),
          colors: [Color.fromARGB(219, 248, 250, 249), Colors.white70],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: -0,
            left: -40,
            child: topWidget(screenSize.width),
          ),
          Positioned(
            bottom: -180,
            left: -40,
            child: bottomWidget(screenSize.width),
          ),
          CenterWidget(size: screenSize),
          const LoginContent(),
        ],
      ),
    );
  }
}
