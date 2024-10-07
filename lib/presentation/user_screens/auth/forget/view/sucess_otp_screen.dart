import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:project_5240_frontend/presentation/user_screens/forget_password/verify/view/verify_otp_screen.dart';
import 'package:project_5240_frontend/presentation/widgets/custom_btn.dart';

class SuccessOTPScreen extends StatelessWidget {
  final String? email;

  const SuccessOTPScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: screenheight * 0.001),
              Lottie.asset('assets/images/success.json',
                  height: 200, width: 200),
              SizedBox(height: screenheight * 0.001),
              const Text(
                "Success",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff374151),
                ),
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 42),
                child: Text(
                  textAlign: TextAlign.center,
                  "Please check your email for create a new password",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "inter",
                    fontWeight: FontWeight.w400,
                    color: Color(0xff828282),
                  ),
                ),
              ),
              SizedBox(height: screenheight * 0.028),
              RichText(
                  text: TextSpan(
                text: "Can't get email? ",
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Resubmit',
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color(0xff32B768),
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Get.back();
                        }),
                ],
              )),
              SizedBox(height: screenheight * .05),
              CustomizeButton(
                color: const Color(0xFF32B768),
                onTap: () {
                  Get.off(VerifyOTPScreen(email: email ?? ""));
                },
                width: screenWidth * 0.7,
                text: 'Verify',
                height: screenheight * 0.049,
                textColor: Colors.white,
              ),
            ]),
      ),
    );
  }
}
