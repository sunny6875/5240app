// ignore_for_file: unused_local_variable, prefer_final_fields, must_be_immutable

import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';

import 'package:project_5240_frontend/presentation/user_screens/forget_password/change_password/controller/change_password_controller.dart';

import 'package:project_5240_frontend/utils/extension.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});
  final passwordController = Get.put(ChangePasswordController());
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed:
              !passwordController.isLoading.value ? () => Get.back() : null,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 14, right: 14),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Change New Password",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff374151)),
                ),
                SizedBox(height: screenheight * .004),
                const Text('Enter your new password below',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff9CA3AF))),
                SizedBox(height: screenheight * .06),

                // Current Password Field using TextFormCustom
                Obx(() => TextFormCustom(
                      title: 'Current Password',
                      placeholder: 'Enter Current Password',
                      controller: passwordController.currentpasswordController,
                      obscureText: !passwordController.isCurrentPasswordVisible
                          .value, // Observe visibility state
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        }
                        return null; // Return null if the password is valid
                      },
                      suffix: IconButton(
                        icon: Icon(
                          passwordController.isCurrentPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                        ),
                        onPressed: passwordController
                            .toggleCurrentPasswordVisibility, // Toggle visibility
                      ),
                    )),
                const SizedBox(height: 20),
                Obx(() => TextFormCustom(
                      title: 'New Password',
                      placeholder: 'Enter New Password',
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (value.length < 6) {
                          return 'Password must be at least 6 characters long';
                        }
                        return null; // Return null if the password is valid
                      },
                      controller: passwordController.newpasswordController,
                      obscureText: !passwordController.isNewPasswordVisible
                          .value, // Observe visibility state
                      suffix: IconButton(
                        icon: Icon(
                          passwordController.isNewPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                        ),

                        onPressed: passwordController
                            .toggleNewPasswordVisibility, // Toggle visibility
                      ),
                    )),

                const SizedBox(height: 20),
                Obx(() => TextFormCustom(
                      title: 'Confirm Password',
                      placeholder: 'Re-enter New Password',
                      controller: passwordController.confirmpasswordController,
                      obscureText: !passwordController.isConfirmPasswordVisible
                          .value, // Observe visibility state
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Password cannot be empty';
                        } else if (passwordController.newPassword.value !=
                            passwordController.confirmPassword.value) {
                          return 'Passwords do not match'; // Passwords do not match
                        }
                        return null;
                      },
                      suffix: IconButton(
                        icon: Icon(
                          passwordController.isConfirmPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                        ),
                        onPressed: passwordController
                            .toggleConfirmPasswordVisibility, // Toggle visibility
                      ),
                    )),
                SizedBox(height: screenheight * .130),
                Obx(
                  () {
                    if (passwordController.isLoading.value) {
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
                        color: passwordController.doPasswordsMatch
                            ? const Color.fromRGBO(50, 183, 104, 1)
                            : const Color.fromRGBO(244, 244, 244, 1),
                        textColor: passwordController.doPasswordsMatch
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(156, 163, 175, 1),
                        onPressed: passwordController.doPasswordsMatch
                            ? () {
                                passwordController.updatePassword();
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
      ),
    );
  }
}
