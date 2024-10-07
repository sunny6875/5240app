// ignore_for_file: invalid_use_of_protected_member

import 'package:project_5240_frontend/data/models/domain/domain_model.dart';
import 'package:project_5240_frontend/presentation/user_screens/accounts/controller/account_controller.dart';

import '../../../../utils/extension.dart';

class DomainidController extends GetxController {
  var isLoading = true.obs;
  Rx<DomainModel?> domainModel = Rx<DomainModel?>(null);
  final AccountController accountController = Get.put(AccountController());

  @override
  void onInit() {
    fetchDomain();
    super.onInit();
  }

  Future<void> fetchDomain() async {
    try {
      isLoading(true);
      final dominid = await LocalStore.getdominid();
      final response =
          await BaseClient.get(api: "${EndPoints.allDomains}/$dominid");

      if (response != null && response.statusCode == 200) {
        debugPrint("domain===============>${response.data}");
        domainModel.value = DomainModel.fromJson(response.data);
        debugPrint("domainModel===============>$domainModel");
        accountController.getProfileData();
        update();
      }
    } catch (e) {
      // Get.snackbar('Error', 'Failed to load domain details');
      debugPrint("Error===============>$e");
    } finally {
      isLoading(false);
    }
    update();
  }
}
