import 'package:flutter/material.dart';

import '../constants.dart';

class CustomTextFIeld extends StatelessWidget {
  final String text;
  final TextInputType keyboardType;
  final TextEditingController controller;
  const CustomTextFIeld({ Key? key,
    required this.text,
    this.keyboardType = TextInputType.text,
    required this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: text,
        contentPadding: const EdgeInsets.only(top: 5, bottom: 5, left: 10),
        hintStyle: const TextStyle(
          fontSize: 20,
          color: kBackgroundColor
        )
      ),
      style: const TextStyle(
        fontSize: 20,
        color: kBackgroundColor
      ),
      // onChanged: onpress,
    );
  }
}