import 'package:project_5240_frontend/utils/extension.dart';

class ChangePasswordController extends GetxController {
  TextEditingController currentpasswordController = TextEditingController();
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxString currentPassword = "".obs;
  RxString newPassword = "".obs;
  RxString confirmPassword = "".obs;

// Function to check if the passwords match and are at least 6 characters long
  bool get doPasswordsMatch =>
      newPassword.value.isNotEmpty &&
      confirmPassword.value.isNotEmpty &&
      newPassword.value.length >= 6 &&
      newPassword.value == confirmPassword.value;

  @override
  void onInit() {
    currentpasswordController.addListener(() {
      currentPassword.value = currentpasswordController.text;
    });
    newpasswordController.addListener(() {
      newPassword.value = newpasswordController.text;
    });
    confirmpasswordController.addListener(() {
      confirmPassword.value = confirmpasswordController.text;
    });

    super.onInit();
  }

  // Observable variables for toggling password visibility
  RxBool isCurrentPasswordVisible = false.obs;
  RxBool isNewPasswordVisible = false.obs;
  RxBool isConfirmPasswordVisible = false.obs;

  // Method to toggle the visibility of current password
  void toggleCurrentPasswordVisibility() {
    isCurrentPasswordVisible.value = !isCurrentPasswordVisible.value;
  }

  // Method to toggle the visibility of new password
  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  // Method to toggle the visibility of confirm password
  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

// Handle login logic with API request
  Future<bool> updatePassword() async {
    isLoading.value = true;
    errorMessage.value = '';
    update();

    debugPrint(
        "Current Password===================>${currentpasswordController.text}");
    debugPrint("New Password===================>${newpasswordController.text}");
    try {
      final response =
          await BaseClient.post(api: EndPoints.UPDATEPASSWORD, payloadObj: {
        "oldPassword": currentpasswordController.text.trim(),
        "newPassword": newpasswordController.text.trim(),
      });

      if (response != null && response.statusCode == 200) {
        // Save Data on Loacal
        errorMessage.value = response.data['message'];
        isLoading.value = false;

        Fluttertoast.showToast(msg: errorMessage.value);
        Get.back();
        Future.delayed(const Duration(milliseconds: 200), () {
          currentpasswordController.clear();
          newpasswordController.clear();
          confirmpasswordController.clear();
        });
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
