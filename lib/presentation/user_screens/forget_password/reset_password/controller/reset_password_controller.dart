import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/data/client/baseclient/base_client.dart';
import 'package:project_5240_frontend/data/client/endpoints/endpoints.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/forget/controller/forget_password_controller.dart';
import 'package:project_5240_frontend/presentation/user_screens/forget_password/success.dart';

class ResetPasswordController extends GetxController {
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  final ForgetPasswordController forgetPasswordController =
      Get.find<ForgetPasswordController>();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString newPassword = "".obs;
  RxString confirmPassword = "".obs;

// Function to check if the passwords match
  bool get doPasswordsMatch =>
      newPassword.value.isNotEmpty &&
      confirmPassword.value.isNotEmpty &&
      newPassword.value == confirmPassword.value;
  @override
  void onInit() {
    newpasswordController.addListener(() {
      newPassword.value = newpasswordController.text;
    });
    confirmpasswordController.addListener(() {
      confirmPassword.value = confirmpasswordController.text;
    });
    super.onInit();
  }

// Handle login logic with API request
  Future<bool> resetPassword({String? email}) async {
    isLoading.value = true;
    errorMessage.value = '';
    update();

    debugPrint("Email===================>$email");
    debugPrint("New Password===================>${newpasswordController.text}");
    try {
      final response =
          await BaseClient.post(api: EndPoints.RESETPASSWORD, payloadObj: {
        "userEmail": email,
        "newPassword": newpasswordController.text.trim(),
      });

      if (response != null && response.statusCode == 200) {
        // Save Data on Loacal
        errorMessage.value = response.data['message'];
        isLoading.value = false;

        Fluttertoast.showToast(msg: errorMessage.value);
        Get.off(const SuccessScreen());
        forgetPasswordController.emailController.clear();
        update();
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
}
