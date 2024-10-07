import 'package:flutter/material.dart';

class CustomizeTextField extends StatelessWidget {
  final String hinttext;
  final TextEditingController controller;
  final int? maxLength;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLines; // Add optional maxLines for multiline support
  final int? minLines; // Add optional minLines
  final void Function(String)? onChanged;
  const CustomizeTextField({
    super.key,
    required this.hinttext,
    required this.controller,
    this.maxLength,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1, // Default to a single line
    this.minLines = 1,
    this.onChanged, // Default minimum lines
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 327 / 375,
      height: MediaQuery.of(context).size.height * 50 / 812,
      child: TextField(
        controller: controller,
        maxLength: maxLength,
        onChanged: onChanged,
        obscureText: obscureText,
        keyboardType: keyboardType,
        maxLines: maxLines, // Set the maximum number of lines
        minLines: minLines, // Set the minimum number of lines
        decoration: InputDecoration(
          hintText: hinttext,
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          hintStyle: const TextStyle(color: Color(0xff9CA3AF)),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Color(0xFFBEC5D1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(
              color: Color(0xFFBEC5D1),
            ),
          ),
          counterText: "",
        ),
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      ),
    );
  }
}
