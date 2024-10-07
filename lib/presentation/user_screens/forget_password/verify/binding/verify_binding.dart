import 'package:get/get.dart';
import 'package:project_5240_frontend/presentation/user_screens/forget_password/verify/controller/verify_controller.dart';

class VerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyController());
  }
}
