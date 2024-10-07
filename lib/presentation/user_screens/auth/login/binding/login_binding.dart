import 'package:get/get.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/login/controller/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Lazily initialize the LoginController when the LoginScreen is opened
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
