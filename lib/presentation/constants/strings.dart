import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_5240_frontend/presentation/constants/colors.dart';

class CustomTextSty {
  static TextStyle style24Bold =  TextStyle(
    fontFamily: "OpenSans",
    fontSize: 24.0.sp,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    color: MyColors.zblack
      );

  static TextStyle style14NTextColor = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 14.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: MyColors.grayblack);

  static TextStyle style16TextColor400 = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 16.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: MyColors.grayblack);

  static TextStyle style24TextColor600 = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 24.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: MyColors.black2);

  static TextStyle style14NTextColor700Bold = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 14.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: MyColors.white);

  static TextStyle style14NTextColor7001Bold = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 14.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: MyColors.green);

  static TextStyle style14NTextColor7002Bold = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 14.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w700,
      color: MyColors.lightgray);

  static TextStyle style12NTextColor = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 14.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: const Color(0xFF797A8B));




  static TextStyle style12NTextColorW400 = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 12.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: MyColors.lightgray);

  static TextStyle style14TextW600 = TextStyle(
    fontFamily: "OpenSans",
    fontSize: 14.0.sp,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
      color: MyColors.black2
  );



  static TextStyle style16TextW600 = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 16.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: MyColors.green);

  static TextStyle style12TextBold = TextStyle(
    fontFamily: "OpenSans",
    fontSize: 12.0.sp,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    color: MyColors.green
  );

  static TextStyle style24TextW500 = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 24.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      color: MyColors.black
  );

  static TextStyle style24TextW5001 = TextStyle(
    fontFamily: "OpenSansBold",
    fontSize: 24.0.sp,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
    color: MyColors.grayblack,
  );
  static TextStyle style12BoldW500 = TextStyle(
    fontFamily: "OpenSansBold",
    fontSize: 12.0.sp,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w500,
    color: Colors.orange,
  );
  static TextStyle style16textW400 = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 16.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: MyColors.green);

  static TextStyle style18BoldTextwhite = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 18.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: MyColors.offSky);




  static TextStyle style18blackW400 = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 18.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: MyColors.zblack);

  static TextStyle style22blackw500 = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 22.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w500,
      color: MyColors.lightgray);

  static TextStyle style16blackw600 = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 16.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: MyColors.black2);



  static TextStyle style16balck400 = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 16.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
      color: MyColors.black);

  static TextStyle style14BoldRed = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 14.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: MyColors.lightgray);

  static TextStyle style18BoldRed = TextStyle(
      fontFamily: "OpenSans",
      fontSize: 18.0.sp,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w600,
      color: MyColors.lightgray);

  static TextStyle style14Normal = TextStyle(
    fontFamily: "OpenSans",
    fontSize: 14.0.sp,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static TextStyle style16Bold600 = TextStyle(
    fontFamily: "OpenSans",
    fontSize: 16.0.sp,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  static TextStyle style16400 = TextStyle(
    fontFamily: "OpenSans",
    fontSize: 16.0.sp,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
  );

  static TextStyle style18Bold = TextStyle(
    fontFamily: "OpenSans",
    fontSize: 18.0.sp,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );

  static TextStyle style22Bold = TextStyle(
    fontFamily: "OpenSans",
    fontSize: 22.0.sp,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w600,
  );
}





class Style {
// fontFamily = "";
  static double splashTitleFontSize = 35;
  static double titleFontSize = 18;
  static double labelFontSize = 15;
  static double jobTitleFontSize = 20;
  static double appBarTitleFontSize = 20;

  static TextStyle splashStyle = GoogleFonts.inter(fontSize: splashTitleFontSize, fontWeight: FontWeight.w700, color: MyColors.black);

  static TextStyle titleStyle = GoogleFonts.inter(
    fontSize: titleFontSize,
    fontWeight: FontWeight.w700,
    color: MyColors.black,
  );

  static TextStyle pagetitleStyle = GoogleFonts.inter(
    fontSize: titleFontSize,
    fontWeight: FontWeight.w700,
    color: const Color(0xff101623),
  );

  static TextStyle buttontitleStyle = GoogleFonts.inter(
    fontSize: titleFontSize,
    fontWeight: FontWeight.w400,
    color: const Color(0xff101623),
  );
  static TextStyle labelStyle = GoogleFonts.inter(
    fontSize: labelFontSize,
    fontWeight: FontWeight.w500,
    color: const Color(0xff8B5CF6),
  );
  static TextStyle tabslabelStyle = GoogleFonts.inter(
    fontSize: labelFontSize,
    fontWeight: FontWeight.w600,
    color: MyColors.black,
  );

  static TextStyle jobTitleStyle = GoogleFonts.inter(
    fontSize: jobTitleFontSize,
    fontWeight: FontWeight.w700,
    color: MyColors.black,
  );

  static TextStyle appBarTitleStyle = GoogleFonts.inter(fontSize: appBarTitleFontSize, fontWeight: FontWeight.w600, color: const Color(0xff1E293B));
}

class AppStrings {
  static String skip = "Skip";
  static String mainFeature = "main Feature1";
  static  String mainFeatureDiscription =  "Lorem ipsum dolor sit amet consectetur. Vitae integer lacus bibendum et. Aenean non nibh pharetra magna dignissim. Mi quis sed blandit.";
  static String mainFeature2 = "main Feature2";
  static  String mainFeatureDiscription2 ="Lorem ipsum dolor sit amet consectetur. Lorem tincidunt interdum sed consequat sed pharetra consectetur nec. Et sit ultrices mattis.";
  static String mainFeature3 = "main Feature3";
  static  String mainFeatureDiscription3 ="Lorem ipsum dolor sit amet consectetur. Nibh nunc id interdum ultrices feugiat.";

}

