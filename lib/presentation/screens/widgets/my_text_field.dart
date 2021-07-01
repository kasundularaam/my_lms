import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final bool isPassword;
  final String hintText;
  final double fontSize;

  const MyTextField({
    Key? key,
    required this.onChanged,
    required this.onSubmitted,
    this.focusNode,
    required this.textInputAction,
    required this.isPassword,
    required this.hintText,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: TextField(
        obscureText: isPassword,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        focusNode: focusNode,
        style: TextStyle(
            fontSize: fontSize,
            color: Colors.black,
            fontWeight: FontWeight.w300),
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: const EdgeInsets.all(12.0),
          border: InputBorder.none,
        ),
        textInputAction: textInputAction,
      ),
    );
  }
}
