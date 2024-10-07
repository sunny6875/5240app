// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/forget/controller/forget_password_controller.dart';
import 'package:project_5240_frontend/presentation/widgets/custom_btn.dart';
import 'package:project_5240_frontend/presentation/widgets/text_form_fields.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({super.key});

  ForgetPasswordController controller = Get.put(ForgetPasswordController());

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenheight * 117 / 812),
                  const Text(
                    "Forget Password",
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
                  SizedBox(height: screenheight * .050),
                  TextFormCustom(
                    controller: controller.emailController,
                    title: "E-mail",
                    placeholder: "Enter your email",
                    fontWeight: FontWeight.w400,
                    validator: controller.validateEmail,
                  ),
                  SizedBox(height: screenheight * .016),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: RichText(
                        text: TextSpan(
                      text: 'Remember the password? ',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          recognizer: TapGestureRecognizer()..onTap = Get.back,
                          text: 'Sign in',
                          style: const TextStyle(
                            fontSize: 14.0,
                            color: Color(0xff32B768),
                          ),
                        ),
                      ],
                    )),
                  ),
                  SizedBox(height: screenheight * .05),
                  Center(
                    child: Obx(() => controller.isLoading.value
                        ? const NutsActivityIndicator(
                            activeColor: Colors.white,
                            inactiveColor: AppColors.green,
                            tickCount: 24,
                            relativeWidth: 0.4,
                            radius: 20,
                            startRatio: 0.7,
                            animationDuration: Duration(milliseconds: 500),
                          )
                        : CustomizeButton(
                            color: controller.isFormValid()
                                ? const Color.fromRGBO(50, 183, 104, 1)
                                : const Color.fromRGBO(244, 244, 244, 1),
                            textColor: controller.isFormValid()
                                ? const Color.fromRGBO(255, 255, 255, 1)
                                : const Color.fromRGBO(156, 163, 175, 1),
                            width: screenWidth * 0.7,
                            text: 'Submit',
                            height: screenheight * 0.049,
                            onTap: controller.isFormValid()
                                ? controller.submit
                                : () {},
                          )),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
