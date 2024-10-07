import 'package:project_5240_frontend/presentation/domain_side/addsubdomin/controller/basicitem_controller.dart';
import 'package:project_5240_frontend/utils/extension.dart';

class BasicItemBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BasicItemsController());
  }
}
