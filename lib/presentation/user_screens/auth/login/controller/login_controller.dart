import 'package:project_5240_frontend/data/models/auth/user_model.dart';
import 'package:project_5240_frontend/utils/extension.dart';

class LoginController extends GetxController {
  RxBool isObscured = true.obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  // Observable variables

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxString email = ''.obs;
  RxString password = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Add listeners to the controllers to update observable variables
    emailController.addListener(() {
      email.value = emailController.text;
    });
    passwordController.addListener(() {
      password.value = passwordController.text;
    });
  }

  @override
  void onClose() {
    // Dispose of controllers when the controller is removed from memory
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
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
    }
    return null;
  }

  // Check if form is valid
  isFormValid() {
    final emailValid = validateEmail(email.value) == null;
    final passwordValid = validatePassword(password.value) == null;

    return emailValid && passwordValid;
  }

  // Toggle password visibility
  void toggleVisibility() {
    isObscured.value = !isObscured.value;
  }

  // Handle login logic with API request
  Future<bool> login({String? email, String? password}) async {
    isLoading.value = true;
    errorMessage.value = '';
    update();
    try {
      final response = await BaseClient.post(api: EndPoints.LOGIN, payloadObj: {
        "userEmail": email,
        "password": password,
      });

      if (response != null && response.statusCode == 200) {
        UserModel userModel = UserModel.fromJson(response.data);
        debugPrint("User Data : $userModel");
        debugPrint("Email : ${userModel.user?.email}");

        // Save Data on Loacal
        await LocalStore.saveUserData(
            token: userModel.token ?? "",
            id: userModel.user?.id ?? "",
            email: userModel.user?.email ?? "",
            userName: userModel.user?.userName ?? "",
            isProvider: userModel.user?.isDomainProvider ?? false);

        final localToken = await LocalStore.getToken();
        final getUserEmail = await LocalStore.getUserEmail();

        if (userModel.user != null &&
            userModel.user!.isDomainProvider == true) {
          final domainId = userModel.user!.domainId ?? "";
          await LocalStore.savedominid(domainId);
          update();
        }
        final getdominid = await LocalStore.getdominid();
        debugPrint("Local data getdominid==========>$getdominid");
        debugPrint("localToken: $localToken");
        debugPrint("getUserEmail: $getUserEmail");
        errorMessage.value = response.data['message'];
        isLoading.value = false;
        update();
        Fluttertoast.showToast(msg: errorMessage.value);
        Future.delayed(const Duration(milliseconds: 200), () {
          emailController.clear();
          passwordController.clear();
        });
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

  // Handle login process with form validation
  Future<void> loginWithEmail() async {
    if (isFormValid()) {
      debugPrint("Email: ${emailController.value.text}");
      debugPrint("Password: ${passwordController.value.text}");
      final email = emailController.value.text.trim();
      final password = passwordController.value.text.trim();
      final success = await login(
        email: email,
        password: password,
      );

      if (success) {
        debugPrint("Login successful");
        Get.offAll(
          const HomeScreen(),
        );
      } else {
        debugPrint("Login failed: ${errorMessage.value}");
      }
    } else {
      debugPrint("Invalid data");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
