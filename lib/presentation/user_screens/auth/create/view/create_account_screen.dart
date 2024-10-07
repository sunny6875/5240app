import 'package:project_5240_frontend/utils/extension.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});
  // final createController = Get.put(CreateController());
  @override
  Widget build(BuildContext context) {
    Get.put(CreateController());

    return GetBuilder<CreateController>(builder: (controller) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
            child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormCustom(
                controller: controller.nameController,
                title: "Full Name",
                placeholder: "Enter your full name",
                fontWeight: FontWeight.w400,
                validator: controller.validateName,
              ),
              const SizedBox(height: 16),
              TextFormCustom(
                controller: controller.emailController,
                title: "Email address",
                placeholder: "Enter your email",
                fontWeight: FontWeight.w400,
                validator: controller.validateEmail,
              ),
              const SizedBox(height: 16),
              TextFormCustom(
                controller: controller.passwordController,
                obscureText: controller.isObscured.value,
                title: "Password",
                placeholder: "Enter your password",
                fontWeight: FontWeight.w400,
                suffix: IconButton(
                  icon: Icon(
                    controller.isObscured.value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    size: 18,
                  ),
                  onPressed: controller.toggleVisibility,
                ),
                validator: controller.validatePassword,
              ),
                const SizedBox(height: 20,),
                SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      Obx(() => Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            controller.updateSelection(true);
                            debugPrint("Provider selected");
                          },
                          child: Row(
                            children: [
                              Radio<bool>(
                                groupValue: controller.isProviderSelected.value,
                                value: true, // Provider
                                activeColor: AppColors.green,
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    controller.updateSelection(value);
                                    debugPrint("Provider selected: $value");
                                  }
                                },
                              ),
                              const Text(
                                "Provider",
                                style: TextStyle(
                                  fontFamily: "inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      const SizedBox(width: 16),
                      Obx(() => Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: () {
                            controller.updateSelection(false);
                            debugPrint("User selected");
                          },
                          child: Row(
                            children: [
                              Radio<bool>(
                                groupValue: controller.isProviderSelected.value,
                                value: false, // User
                                activeColor: AppColors.green,
                                onChanged: (bool? value) {
                                  if (value != null) {
                                    controller.updateSelection(value);
                                    debugPrint("User selected: $value");
                                  }
                                },
                              ),
                              const Text(
                                "User",
                                style: TextStyle(
                                  fontFamily: "inter",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
                      const Spacer(),
                    ],
                  ),
                ),


                const SizedBox(height: 50),
              Obx(
                () => controller.isLoading.value
                    ? const CircularProgressIndicator(
                        color: AppColors.green,
                      )
                    : CustomCommonButton(
                        title: "Register",
                        color: controller.isFormValid()
                            ? const Color.fromRGBO(50, 183, 104, 1)
                            : const Color.fromRGBO(244, 244, 244, 1),
                        textColor: controller.isFormValid()
                            ? const Color.fromRGBO(255, 255, 255, 1)
                            : const Color.fromRGBO(156, 163, 175, 1),
                        onPressed: controller.isFormValid()
                            ? controller.registerWithEmail
                            : () {},
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
        )),
      );
    });
  }
}
