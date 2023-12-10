// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ZoomInButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const ZoomInButton({
    Key? key,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        iconSize: 35,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
         
