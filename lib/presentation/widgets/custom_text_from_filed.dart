import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? title;
  final TextStyle? style;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool obscureText;
  final String? Function(String?)? validator;
  const CustomTextFormField(
      {super.key,
        this.title,
        this.style,
        this.obscureText = false,
        this.controller,
        this.onChanged,
        this.validator});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(title ?? "", style: style),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
