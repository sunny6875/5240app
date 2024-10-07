import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/data/client/baseclient/base_client.dart';
import 'package:project_5240_frontend/data/client/endpoints/endpoints.dart';
import 'package:project_5240_frontend/presentation/user_screens/forget_password/reset_password/reset_password.dart';

class VerifyController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString otpCode = "".obs;
  RxInt remainingTime = 600.obs; // 10 minutes in seconds
  Timer? timer;

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

// Handle login logic with API request
  Future<bool> verifyCode({String? email, String? otpCode}) async {
    isLoading.value = true;
    errorMessage.value = '';
    update();
    try {
      final response =
          await BaseClient.post(api: EndPoints.VERIFYOTP, payloadObj: {
        "userEmail": email,
        "otp": otpCode,
      });

      if (response != null && response.statusCode == 200) {
        // Save Data on Loacal
        errorMessage.value = response.data['message'];
        isLoading.value = false;

        Fluttertoast.showToast(msg: errorMessage.value);
        Get.off(ResetPassword(email: email));

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

  void startTimer() {
    remainingTime = 150.obs; // Reset to 10 minutes
    timer?.cancel(); // Cancel any existing timer before starting a new one
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingTime > 0) {
        remainingTime--;
        update();
      } else {
        timer.cancel();
        update();
      }
    });
  }

  String formatTime(int seconds) {
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
    update();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }
}
