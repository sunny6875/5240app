import 'package:get/get.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/create/controller/craete_controller.dart';

class CreateBinding extends Bindings {
  @override
  void dependencies() {
    // Lazily initialize the LoginController when the LoginScreen is opened
    Get.lazyPut<CreateController>(() => CreateController());
  }
}
