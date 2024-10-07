import 'package:flutter/material.dart';

class AppColors {
//Basic Colors
  static const Color white = Color(0xFFffffff);
  static const Color black = Color(0xFF000000);
  static const Color lighGrey = Color.fromRGBO(217, 217, 217, 1);
  // Primary Colors
  static const Color primaryColor = Color.fromRGBO(142, 108, 239, 1);
  static const Color greyNav = Color.fromRGBO(157, 178, 206, 1);

  // Secondary Colors
  static const Color secondaryColor = Color(0xFF2D2B2E);
  static const Color secondaryVariant = Color(0xFF252831);
  static const Color secondaryVariant1 = Color(0xFF242424);
  static const Color secondaryVariant2 = Color(0xFF343A40);
  static const Color secondaryVariant3 = Color(0xFFCBD5E1);
  static const Color secondaryVariant4 = Color(0xFF94A3B8);
  static const Color secondaryVariant5 = Color(0xFF171818);
  static const Color secondaryVariant6 = Color(0xFF0D1634);

  static const Color secondaryVariant8 = Color(0xFF808080);

  static const Color secondaryVariant7 = Color(0xFF505353);

//Tertiary Colors
  static const Color tertiaryColor = Color(0xFF909090);
  static const Color tertiaryVariant = Color(0xFFE1DCDC);
  static const Color tertiaryVariant1 = Color(0xFF464646);
  static const Color tertiaryVariant2 = Color(0xFF848484);
  static const Color tertiaryVariant3 = Color(0xFFF4F4F4);
  static const Color tertiaryVariant4 = Color(0xffD9D9D9);
  static const Color tertiaryVariant5 = Color(0xff333333);
  static const Color tertiaryVariant6 = Color(0xff272727);
  //Primary Button Colors
  static const Color primaryButtonColor = Color.fromRGBO(142, 108, 239, 1);
  static const Color primaryDisableButtonColor = Color(0xFFFFA97F);
  static const Color trackColor = Color(0xFF6A6DCD);
  static const Color inActiveTrackColor = Color(0xFF307FE2);

  static const Color dividerColor = Color(0xff0d16340d);
  static const Color searchColor = Color(0xffE2E8F0);
  static const Color orangeColor = Color(0xffFFCD6B);
  static const Color starOrangeColor = Color(0xffE6BB66);
  static const Color transparent = Colors.transparent;
  static const Color backIconColor = Color(0xffCFCFCF);
  static const Color starColor = Color(0xffEBEBEB);
  static const Color starRedColor = Color(0xffFF4B55);
  static const Color blueColor = Color(0xff2563EB);
  static const Color textFromFiledColor = Color(0xffF7F7F7);
  static const Color green = Color.fromRGBO(45, 121, 109, 1);
  static const Color olive = Color(0xff1E5A84);

  // TextColor
  static const Color borderColor = Color.fromRGBO(226, 232, 240, 1);
  static const Color hintColor = Color.fromRGBO(148, 163, 184, 1);
  static const Color lineColor = Color.fromRGBO(196, 196, 196, 1);
  static const Color purpleColor = Color(0xff8E6CEF);

  ///

  static Color greyDivider = const Color(0xffE5E7EB);
  static Color alertIconColor = const Color(0xffF5F8FF);
  static Color lightPurpleBgColor = const Color(0xffF4F1FD);
  static Color containerBackground1 = const Color(0xffE2E8F0);
  static Color notificationActiveColor = const Color(0xffEDF3FF);
  static Color unselectedColor = const Color(0xffADAFBB);

  static Color black2 = const Color(0xff1F2937);
  static Color zblack = const Color(0xff1C1C1C);
  static Color grayblack = const Color(0xff4B5563);
  static Color lightgray = const Color(0xff9CA3AF);
  static Color shadedBalck = const Color(0xff6B7280);
  static Color lightBlack = const Color(0xff1F2937);
  static const Color blackText = Color(0xff5E5E5E);

  static Color greenLight = const Color(0xff10B981);
  static Color ovelGreen = const Color(0xff32B768);
  static Color liteGreen = const Color(0xffD1FAE5);

  /// colors in white gray
  static Color gray = const Color(0xff98A8B8);
  static Color darkgray = const Color(0xff89909E);
  static Color offSky = const Color(0xffF2F9FF);
  static Color browngray = const Color(0xffC4C4C4);

  /// colors in orange
  static Color orange = const Color(0xffEF9F27);

  /// colors in blue
  static Color blue = const Color(0xff2C8DFF);

  /// colors in gray
  static const lightgrayBlack = Color(0xff838383);
  static const editTextColor = Color(0xff555555);
  static const search_bg = Color(0xffE6E7E9);

  static Color parseColor(String colorStr) {
    // Remove the leading '#' if present
    colorStr = colorStr.replaceAll('#', '');

    // Check if the color string is in the format of `AARRGGBB`
    if (colorStr.length == 8) {
      return Color(int.parse('0x$colorStr'));
    } else if (colorStr.length == 6) {
      // Default to fully opaque if alpha is not provided
      return Color(int.parse('0xFF$colorStr'));
    } else {
      throw const FormatException('Invalid color format');
    }
  }
}
