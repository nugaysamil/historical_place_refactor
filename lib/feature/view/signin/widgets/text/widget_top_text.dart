// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TopText extends StatefulWidget {
  final String topText;
  const TopText({
    Key? key,
    required this.topText,
  }) : super(key: key);

  @override
  State<TopText> createState() => _TopTextState();
}

class _TopTextState extends State<TopText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      
      widget.topText,
      style: const TextStyle(
        color: Colors.black54,
        fontSize: 40,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
