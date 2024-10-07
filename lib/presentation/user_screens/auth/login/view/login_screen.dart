import 'package:project_5240_frontend/presentation/user_screens/auth/forget/view/foreget_password.dart';
import 'package:project_5240_frontend/utils/extension.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (controller) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              _emailField(),
              const SizedBox(height: 16),
              _passwordField(),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Color.fromRGBO(50, 183, 104, 1),
                    ),
                  ),
                  onPressed: () {
                    Get.to(ForgetPassword());
                  },
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => controller.isLoading.value
                    ? const CircularProgressIndicator(
                        color: AppColors.green,
                      )
                    : CustomCommonButton(
                        title: "Login",
                        color: controller.isFormValid()
                            ? const Color.fromRGBO(50, 183, 104, 1)
                            : const Color.fromRGBO(244, 244, 244, 1),
                        textColor: controller.isFormValid()
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(156, 163, 175, 1),
                        onPressed: controller.isFormValid()
                            ? controller.loginWithEmail
                            : () {}, // Disable button if form is invalid
                      ),
              ),
              const SizedBox(height: 10),
              const SizedBox(
                width: 148,
                child: Divider(
                  thickness: 0.5,
                  color: Color.fromRGBO(210, 212, 216, 1),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _emailField() {
    return TextFormCustom(
      controller: loginController.emailController,
      title: "E-mail",
      placeholder: "Enter your email",
      fontWeight: FontWeight.w400,
      validator: loginController.validateEmail,
    );
  }

  Widget _passwordField() {
    return Obx(() {
      return TextFormCustom(
        controller: loginController.passwordController,
        title: "Password",
        placeholder: "Password",
        fontWeight: FontWeight.w400,
        validator: loginController.validatePassword,
        obscureText: loginController.isObscured.value,
        suffix: IconButton(
          icon: Icon(
            loginController.isObscured.value
                ? Icons.visibility_off_outlined
                : Icons.visibility_outlined,
            size: 18,
          ),
          onPressed: loginController.toggleVisibility,
        ),
      );
    });
  }
}
