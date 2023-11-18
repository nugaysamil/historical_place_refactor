// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController textController;

  const TextInputField({
    Key? key,
    required this.textController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      child: SizedBox(
        height: 50,
        child: Material(
            elevation: 0,
            shadowColor: Colors.black87,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: TextField(
              controller: textController,
              textAlignVertical: TextAlignVertical.center,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 132, 115, 239),
                    width: 2.0,
                  ),
                ),
                filled: true,
                fillColor: Color.fromARGB(255, 228, 231, 245),
              ),
            )),
      ),
    );
  }
}
