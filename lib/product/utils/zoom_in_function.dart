import 'package:flutter/material.dart';

class ZoomInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ZoomInButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        iconSize: 35,
        icon: Icon(
          Icons.zoom_out,
          color: Colors.white,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
