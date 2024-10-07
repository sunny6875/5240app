import 'package:get/get.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/forget/controller/forget_password_controller.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController());
  }
}
