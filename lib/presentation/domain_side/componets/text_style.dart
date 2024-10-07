// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle normalTextStyle({
    Color color = Colors.black,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w400,
    bool isOverflow = false,
  }) {
    // GoogleFonts
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      overflow: isOverflow ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }

  static TextStyle smallTextStyle({
    Color color = Colors.grey,
    double fontSize = 12.0,
    FontWeight fontWeight = FontWeight.w400,
    bool isOverflow = false,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      overflow: isOverflow ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }

  static TextStyle mediumTextStyle({
    Color color = Colors.black,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w500,
    bool isOverflow = false,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      overflow: isOverflow ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }

  static TextStyle semiBoldTextStyle({
    Color color = Colors.black,
    double fontSize = 16.0,
    FontWeight fontWeight = FontWeight.w600,
    bool isOverflow = false,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      overflow: isOverflow ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }

  static TextStyle boldTextStyle({
    Color color = Colors.black,
    double fontSize = 24.0,
    FontWeight fontWeight = FontWeight.w700,
    bool isOverflow = false,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      overflow: isOverflow ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }
}

class FontSize {
  static const double extraSmall = 10.0;
  static const double small = 12.0;
  static const double normal = 14.0;
  static const double defaultFont = 15.0;
  static const double large = 16.0;
  static const double extraLarge = 18.0;
  static const double extraDoubleLarge = 20.0;
  static const double buttonText = 18.0;
  static const double heading = 24.0;
  static const double heading_22 = 22.0;
  static const double Large_34 = 34.0;
}

class FontSize1 {
  static const double extraSmall = 10.0;
  static const double small = 12.0;
  static const double normal = 14.0;
  static const double defaultFont = 15.0;
  static const double large = 16.0;
  static const double extraLarge = 18.0;
  static const double extraDoubleLarge = 20.0;
  static const double buttonText = 18.0;
  static const double heading = 24.0;
  static const double heading_22 = 22.0;
  static const double Large_34 = 34.0;
}

class PaddingSize {
  static const double extraSmall = 4.0;
  static const double small = 8.0;
  static const double middle = 12.0;
  static const double normal = 16.0;
  static const double standard = 18.0;
  static const double large = 20.0;
  static const double extraLarge = 24.0;
}

class IconSize {
  static const double extraSmall = 12.0;
  static const double small = 18.0;
  static const double normal = 24.0;
  static const double large = 32.0;
  static const double extraLarge = 40.0;
}

class MarginSize {
  static const double extraSmall = 5.0;
  static const double small = 8.0;
  static const double middle = 12.0;
  static const double middle_14 = 14.0;
  static const double normal = 16.0;
  static const double large = 20.0;
  static const double defaulty = 24.0;
  static const double extraLarge = 32.0;
  static const double extraLarge_50 = 50.0;
}

enum TextStyleType { normal, medium, semibold, bold }
