import 'package:project_5240_frontend/data/models/auth/user_model.dart';
import 'package:project_5240_frontend/utils/extension.dart';

import '../../../../domain_side/adddomin/add_domain_widget.dart';

class CreateController extends GetxController {
  RxBool isRemembered = false.obs;
  RxBool isObscured = true.obs; // Make it observable for reactive updates
  RxBool isLoading = false.obs;
  RxString? errorMessage = ''.obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxString name = "".obs;
  RxString email = "".obs;
  RxString password = "".obs;
  Rx<bool?> isProviderSelected = Rx<bool?>(null);

  void updateSelection(bool value) {
    isProviderSelected.value = value;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController.addListener(() {
      name.value = nameController.text;
    });
    emailController.addListener(() {
      email.value = emailController.text;
    });
    passwordController.addListener(() {
      password.value = passwordController.text;
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Method to toggle password visibility
  void toggleVisibility() {
    isObscured.value = !isObscured.value; // Toggle visibility
    update();
  }

  // Name validation logic
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
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

  // Password validation logic
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Method to check if the form is valid
  isFormValid() {
    final nameValid = validateName(name.value) == null;
    final emailValid = validateEmail(email.value) == null;
    final passwordValid = validatePassword(password.value) == null;
    final isValue = isProviderSelected.value != null;
    return nameValid && emailValid && passwordValid && isValue;
  }

  // Method to handle registration process
  Future<bool> register(
      {bool? isDomainProvider,
      String? name,
      String? email,
      String? password}) async {
    isLoading.value = true;
    errorMessage?.value = "";
    update();
    debugPrint("Provider======>$isDomainProvider");
    try {
      final response =
          await BaseClient.post(api: EndPoints.REGISTER, payloadObj: {
        "userName": name,
        "userEmail": email,
        "password": password,
        "isDomainProvider": isDomainProvider,
      });

      if (response != null && response.statusCode == 201 ||
          response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        debugPrint(
            "After upload Data======>${userModel.user?.isDomainProvider}");
        final token = response.data['token'];
        debugPrint("Token======>$token");

        LocalStore.saveToken(token);
        // Save Data on Loacal
        await LocalStore.saveUserData(
            token: userModel.token ?? "",
            id: userModel.user?.id ?? "",
            email: response.data["user"]["email"] ?? "",
            userName: userModel.user?.userName ?? "",
            isProvider: userModel.user?.isDomainProvider ?? false);
        final getProvider = await LocalStore.getIsProvider();
        debugPrint("Local Provider===========$getProvider");
        isLoading.value = false;
        Fluttertoast.showToast(msg: response.data['message']);
        update();
        return true;
      } else {
        isLoading.value = false;
        Fluttertoast.showToast(msg: response.data['message']);
        update();
        return false;
      }
    } catch (e) {
      errorMessage?.value = 'An error occurred. Please try again.';
      isLoading.value = false;
      update();
      return false;
    } finally {
      // Fluttertoast.showToast(msg: errorMessage!.value);
    }
  }

  // Method to handle registration with form validation
  Future<void> registerWithEmail() async {
    if (isFormValid()) {
      debugPrint("Name===================>${nameController.text.trim()}");
      debugPrint("Email===================>${emailController.text.trim()}");
      debugPrint("Password=================>${passwordController.text.trim()}");
      debugPrint("isDomainProvider===============>${isProviderSelected.value}");
      register(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        isDomainProvider: isProviderSelected.value,
      ).then((success) {
        if (success) {
          if (isProviderSelected.value == true) {
            Get.offAll(AddDomainWidget());
          } else {
            Get.offAll(const HomeScreen());
          }
          Future.delayed(const Duration(milliseconds: 2000), () {
            nameController.clear();
            emailController.clear();
            passwordController.clear();
            isProviderSelected.value = null;
          });
        } else {
          // Handle registration failure here
          Fluttertoast.showToast(
            msg: 'Registration Failed',
          );
        }
      });
    } else {
      errorMessage?.value = "Please fill in all fields correctly.";
    }
  }
}
