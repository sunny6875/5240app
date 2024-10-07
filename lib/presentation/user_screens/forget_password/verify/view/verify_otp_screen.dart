// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/forget/controller/forget_password_controller.dart';
import 'package:project_5240_frontend/presentation/user_screens/forget_password/verify/controller/verify_controller.dart';
import 'package:project_5240_frontend/presentation/widgets/custom_common_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

class VerifyOTPScreen extends StatelessWidget {
  final String? email;

  const VerifyOTPScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final VerifyController verifyController = Get.put(VerifyController());
    final ForgetPasswordController forgetPasswordController =
        Get.find<ForgetPasswordController>();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 117 / 812),
              const Text(
                "Enter 6 Digit Code",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff374151),
                ),
              ),
              SizedBox(height: screenHeight * .004),
              RichText(
                text: TextSpan(
                  text:
                      'Enter the 6 digit code that you received\non your email\n',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.3,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff808080),
                  ),
                  children: [
                    TextSpan(
                      text: '$email', // Email text part
                      style: const TextStyle(
                        fontWeight: FontWeight.w600, // Bolder weight for email
                        color: Colors.black, // Different color for the email
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * .063),
              Center(
                child: SizedBox(
                  height: screenHeight * 0.07,
                  width: screenWidth * 0.9,
                  child: PinFieldAutoFill(
                    decoration: BoxLooseDecoration(
                      strokeColorBuilder:
                          const FixedColorBuilder(Color(0xffE6E6E6)),
                      bgColorBuilder:
                          const FixedColorBuilder(Colors.transparent),
                      radius: const Radius.circular(8),
                    ),
                    codeLength: 6,
                    onCodeChanged: (code) {
                      verifyController.otpCode.value = code.toString();
                      if (code != null && code.length == 6) {
                        debugPrint("OTP Code: $code");
                        verifyController.verifyCode(
                            email: email ?? "", otpCode: code);
                      }
                    },
                    cursor: Cursor(
                      width: 2,
                      color: Colors.black,
                      enabled: true,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * .030),
              Obx(
                () => Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: 'Email not received? ',
                      style: const TextStyle(
                        height: 2,
                        fontSize: 14.0,
                        color: Color(0xff808080),
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              if (verifyController.remainingTime.value == 0) {
                                forgetPasswordController.sendOTPWithEmail(
                                    email: email);
                              } else {
                                debugPrint("Please wait ................");
                              }
                            },
                          text: 'Resend code',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor:
                                verifyController.remainingTime.value == 0
                                    ? AppColors.green
                                    : Colors.black,
                            fontSize: 14.0,
                            color: verifyController.remainingTime.value == 0
                                ? AppColors.green
                                : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text:
                              "\nResend code in ${verifyController.formatTime(verifyController.remainingTime.value)}",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(height: screenHeight * 0.080),
              Obx(
                () {
                  if (forgetPasswordController.isLoading.value ||
                      verifyController.isLoading.value) {
                    return const Center(
                      child: NutsActivityIndicator(
                        activeColor: Colors.white,
                        inactiveColor: AppColors.green,
                        tickCount: 24,
                        relativeWidth: 0.4,
                        radius: 20,
                        startRatio: 0.7,
                        animationDuration: Duration(milliseconds: 500),
                      ),
                    );
                  }
                  return Center(
                    child: CustomCommonButton(
                      title: "verified",
                      color: verifyController.otpCode.value.length == 6
                          ? const Color.fromRGBO(50, 183, 104, 1)
                          : const Color.fromRGBO(244, 244, 244, 1),
                      textColor: verifyController.otpCode.value.length == 6
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(156, 163, 175, 1),
                      onPressed: verifyController.otpCode.value.length == 6
                          ? verifyController.verifyCode
                          : () {}, // Disable button if form is invalid
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
