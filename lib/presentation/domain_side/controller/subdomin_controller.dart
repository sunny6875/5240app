import 'package:project_5240_frontend/data/models/provider_side_model/sub_domain_model.dart';

import '../../../../utils/extension.dart';

class SubdominController extends GetxController {
  var subdomains = [].obs; // Observable list for subdomains
  var filteredSubdomains = [].obs; // Filtered list for search results
  SubDomainModel? subDomainModel;

  var isLoading = false.obs;
  var searchQuery = ''.obs; // Observable for search query

  @override
  void onInit() {
    super.onInit();
    fetchSubDomains();
    debounce(searchQuery, (_) => filterSubdomains(),
        time: const Duration(milliseconds: 300)); // Debouncing search
  }

  Future<void> fetchSubDomains() async {
    isLoading(true);
    try {
      final dominid = await LocalStore.getdominid();

      final response = await BaseClient.get(
          api: "${EndPoints.allDomains}/$dominid/subdomain");
      if (response != null && response.statusCode == 200) {
        debugPrint("response-----------------${response.data}");
        subDomainModel = SubDomainModel.fromJson(response.data);

        subdomains.value = response.data["subdomains"] ?? [];
        filteredSubdomains.value = subdomains;
        debugPrint("response-----------------$filteredSubdomains");
        isLoading(false);
        update();
      } else {
        debugPrint("Error fetching domains");
        isLoading(false);
      }
    } catch (e) {
      debugPrint('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  void filterSubdomains() {
    if (searchQuery.value.isEmpty) {
      filteredSubdomains.value =
          subdomains; // Reset to full list if search is empty
    } else {
      filteredSubdomains.value = subdomains
          .where((subdomain) => subdomain["title"]!
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList();
    }
    update();
  }
}
