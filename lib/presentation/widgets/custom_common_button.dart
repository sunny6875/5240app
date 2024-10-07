// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomCommonButton extends StatelessWidget {
  final Color? color;
  final String? title;
  final Color? textColor;
  final void Function()? onPressed;
  const CustomCommonButton({
    super.key,
    this.color,
    this.title,
    this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final sized = MediaQuery.of(context).size;
    return MaterialButton(
      height: 49,
      minWidth: sized.width * 0.6,
      elevation: 0,
      onPressed: onPressed,
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title ?? "",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w700, color: textColor),
      ),
    );
  }
}
