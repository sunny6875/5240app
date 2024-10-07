import 'package:flutter/material.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';

class TextFormCustom extends StatelessWidget {
  final String title;
  final String placeholder;
  final Widget? suffix;
  final InputBorder? focusedBorder;
  final InputBorder? enableBorder;
  final InputBorder? border;
  final FontWeight? fontWeight;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function(String)? onChanged;
  final EdgeInsetsGeometry? contentPadding;
  final double? fontSize;
  final int? maxLength;
  const TextFormCustom(
      {super.key,
      required this.title,
      required this.placeholder,
      this.suffix,
      this.maxLength,
      this.focusedBorder,
      this.enableBorder,
      this.border,
      this.onChanged,
      this.contentPadding,
      this.obscureText = false,
      this.validator,
      this.fontWeight,
      this.controller,
      this.fontSize,
      this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color.fromRGBO(156, 163, 175, 1),
            fontSize: 14,
            fontFamily: 'inter',
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: keyboardType,
          key: key,
          maxLength: maxLength,
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          obscureText: obscureText,
          decoration: InputDecoration(
            counterText: '',
            contentPadding: contentPadding ??
                const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: fontSize ?? 14,
              fontWeight: FontWeight.w400,
              fontFamily: 'Lexend',
              color: AppColors.hintColor,
            ),
            suffixIcon: suffix,
            suffixIconConstraints:
                BoxConstraints.loose(const Size.fromHeight(30)),
            // suffixIconConstraints: BoxConstraints(
            border: border ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.borderColor)),
            enabledBorder: enableBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.borderColor)),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.borderColor)),
          ),
        ),
      ],
    );
  }
}
