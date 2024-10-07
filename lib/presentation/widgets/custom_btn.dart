// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

class CustomizeButton extends StatelessWidget {
  final String text;
  final width;
  final height;
  final color;
  final textColor;
  final VoidCallback onTap;
  const CustomizeButton(
      {super.key,
      required this.text,
      this.width,
      this.height,
      required this.onTap,
      this.color,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    bool isButtonActive = false;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          //color: _isButtonActive ? Color(0xFF32B768) : Color(0xFFF4F4F4),

          //   color: Color(0xFFF4F4F4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 16, color: textColor),
          ),
        ),
      ),
    );
  }
}
