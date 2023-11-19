import 'package:flutter/material.dart';

class SpecialTexts extends StatelessWidget {
  const SpecialTexts({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, top: 10),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.shade700,
          fontSize: 15,
        ),
      ),
    );
  }
}
