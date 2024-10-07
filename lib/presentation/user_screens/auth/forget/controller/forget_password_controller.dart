import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:project_5240_frontend/data/client/baseclient/base_client.dart';
import 'package:project_5240_frontend/data/client/endpoints/endpoints.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/auth_tab/auth_tab_screen.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/forget/view/sucess_otp_screen.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString email = "".obs;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(() {
      email.value = emailController.text;
    });
  }

// Email validation logic
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Check if form is valid
  isFormValid() {
    final emailValid = validateEmail(email.value) == null;
    return emailValid;
  }

  void goToLogin() {
    Get.to(const AuthTabScren(currentIndex: 2));
  }

// Handle login logic with API request
  Future<bool> sendOTPWithEmail({String? email}) async {
    isLoading.value = true;
    errorMessage.value = '';
    update();
    try {
      final response = await BaseClient.post(
          api: EndPoints.SENDOTPFORFORGETPASSWORD,
          payloadObj: {
            "userEmail": email,
          });

      if (response != null && response.statusCode == 200) {
        // Save Data on Loacal
        errorMessage.value = response.data['message'];
        isLoading.value = false;
        update();
        Fluttertoast.showToast(msg: errorMessage.value);
        return true;
      } else {
        errorMessage.value = response.data['message'] ?? 'Login failed';
        isLoading.value = false;
        Fluttertoast.showToast(msg: errorMessage.value);
        update();
        return false;
      }
    } catch (e) {
      errorMessage.value = 'please check internet connection..';
      Fluttertoast.showToast(msg: errorMessage.value);
      isLoading.value = false;
      update();
      return false;
    } finally {
      Fluttertoast.showToast(msg: errorMessage.value);
      update();
    }
  }

  void submit() {
    if (isFormValid()) {
      debugPrint("Email=======================>${email.value}");
      sendOTPWithEmail(email: emailController.text).then((success) {
        if (success) {
          debugPrint("send OTP successful");
          Get.to(SuccessOTPScreen(email: emailController.text));
        } else {
          debugPrint("OTP send failed: ${errorMessage.value}");
        }
      });
    } else {
      // Handle the email submission logic
      debugPrint("Invalid data");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
