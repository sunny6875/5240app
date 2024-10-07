// ignore_for_file: unused_local_variable, prefer_final_fields, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/presentation/user_screens/forget_password/reset_password/controller/reset_password_controller.dart';
import 'package:project_5240_frontend/presentation/widgets/custom_common_button.dart';

import 'package:project_5240_frontend/presentation/widgets/textfield.dart';

class ResetPassword extends StatelessWidget {
  final String? email;
  ResetPassword({super.key, this.email});
  final controller = Get.put(ResetPasswordController());
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenheight * 117 / 812),
              const Text(
                "Change New Password",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff374151)),
              ),
              SizedBox(height: screenheight * .004),
              const Text('Enter your registered email below',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff9CA3AF))),
              SizedBox(height: screenheight * .09),
              const Text('New Password',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff9CA3AF))),
              SizedBox(height: screenheight * .005),
              CustomizeTextField(
                //width: screenWidth * 0.09,
                hinttext: '**** **** ****',
                controller: controller.newpasswordController,
              ),
              SizedBox(height: screenheight * .008),
              const Text('Confirm Password',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff9CA3AF))),
              SizedBox(height: screenheight * .005),
              CustomizeTextField(
                  //  width: screenWidth * 0.09,
                  hinttext: '**** **** ****',
                  controller: controller.confirmpasswordController),
              SizedBox(height: screenheight * .050),
              Obx(
                () {
                  if (controller.isLoading.value) {
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
                      color: controller.doPasswordsMatch
                          ? const Color.fromRGBO(50, 183, 104, 1)
                          : const Color.fromRGBO(244, 244, 244, 1),
                      textColor: controller.doPasswordsMatch
                          ? const Color.fromRGBO(255, 255, 255, 1)
                          : const Color.fromRGBO(156, 163, 175, 1),
                      onPressed: controller.doPasswordsMatch
                          ? () {
                              controller.resetPassword(email: email);
                            }
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
