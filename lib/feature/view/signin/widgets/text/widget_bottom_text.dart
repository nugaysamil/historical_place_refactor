import 'package:flutter/material.dart';

class BottomText extends StatefulWidget {
  final String? text;
  final String text2;
  final VoidCallback onTapCallback;
  const BottomText({
    Key? key,
    this.text,
    required this.text2,
    required this.onTapCallback,
  }) : super(key: key);

  @override
  State<BottomText> createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTapCallback(); 
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
            ),
            children: [
              TextSpan(
                text: widget.text,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: widget.text2,
                style: const TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
