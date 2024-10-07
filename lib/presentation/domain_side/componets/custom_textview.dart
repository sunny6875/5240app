import 'package:flutter/material.dart';
import 'package:project_5240_frontend/presentation/domain_side/componets/text_style.dart';

class CustomTextView extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  final double? height;
  final bool? translateUsingKey;
  final EdgeInsets? padding;
  final TextStyleType textStyleType;

  const CustomTextView(this.text,
      {super.key,
      this.style,
      this.textAlign,
      this.maxLines,
      this.overflow,
      this.decoration,
      this.height,
      this.translateUsingKey,
      this.textStyleType = TextStyleType.normal,
      this.padding});

  @override
  State<CustomTextView> createState() => _CustomTextViewState();
}

class _CustomTextViewState extends State<CustomTextView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: Text(
        widget.text,
        style: widget.style ??
            (widget.textStyleType == TextStyleType.bold
                ? TextStyles.boldTextStyle()
                : widget.textStyleType == TextStyleType.semibold
                    ? TextStyles.semiBoldTextStyle()
                    : widget.textStyleType == TextStyleType.medium
                        ? TextStyles.mediumTextStyle()
                        : TextStyles.normalTextStyle()),
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        overflow: widget.overflow,
      ),
    );
  }
}
