import '../../../../../utils/extension.dart';

class SubdomainController extends GetxController {
  var isLoading = true.obs;
  var subdomainDetails = {}.obs; // Store as a map for easy access to fields

  final String domainId;
  final String subdomainId;

  SubdomainController(this.domainId, this.subdomainId);

  @override
  void onInit() {
    fetchSubdomainDetails();
    super.onInit();
  }

  void fetchSubdomainDetails() async {
    try {
      isLoading(true);
      final response = await BaseClient.get(
          api: "${EndPoints.allDomains}/$domainId/subdomain/$subdomainId");

      if (response != null && response.statusCode == 201) {
        // Updated to 200
        subdomainDetails.value = response.data[
            'populatedSubdomain']; // Correctly store the populated subdomain
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load subdomain details');
    } finally {
      isLoading(false);
    }
  }
}
