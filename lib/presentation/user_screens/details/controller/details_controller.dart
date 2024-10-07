// ignore_for_file: non_constant_identifier_names
import 'package:project_5240_frontend/utils/extension.dart';

class DetailsController extends GetxController {
  List<String> saveDomainId = [];

  // Method to toggle save state
  Future<void> toggleSave(context, String domainId) async {
    try {
      final response =
          await BaseClient.post(api: "/api/domains/like/$domainId");

      debugPrint("URI ===========>/api/domains/like/$domainId");
      debugPrint(response.statusCode.toString());
      if (response != null && response.statusCode == 200) {
        Fluttertoast.showToast(msg: response.data['message']);
        debugPrint(
            "Save Data Response List===${response.data['data']["user"]["likedDomains"]}");
        List<dynamic> savedCollections =
            response.data['data']["user"]["likedDomains"];

        // Update savedCollectionIds based on API response
        saveDomainId = savedCollections.map((collection) {
          return collection.toString();
        }).toList();

        update(); // Notify listeners to update the UI
      } else {
        debugPrint("Error: ${response.statusCode}");
        Fluttertoast.showToast(msg: response.data['message']);
      }
    } catch (e) {
      debugPrint("Error=======>$e");
    }
  }

  // Method to check if an item is saved
  bool isItemSaved(String collectionId) {
    return saveDomainId.contains(collectionId);
  }

// This method call on settings screen
  // Method to add multiple collection IDs
  void addSavedCollectionIds(List<String>? likedDomains) {
    if (likedDomains != null && likedDomains.isNotEmpty) {
      // Extract collection IDs from saved objects
      List<String> newIds = likedDomains.map((item) => item).toList();

      // Add new IDs to the list, avoiding duplicates if necessary
      saveDomainId.addAll(newIds);

      // Optionally, remove duplicates
      saveDomainId = saveDomainId.toSet().toList();
      debugPrint(saveDomainId.toString());
      // Notify listeners if there are any subscribers
      update();
    }
  }
}
