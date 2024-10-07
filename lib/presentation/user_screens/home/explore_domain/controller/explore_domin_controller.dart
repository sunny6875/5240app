// ignore_for_file: unused_field, non_constant_identifier_names, invalid_use_of_protected_member

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../../../../data/models/provider_side_model/category_model.dart';
import '../../../../../utils/extension.dart';

class ExploreDomainController extends GetxController {
  var isLoading = true.obs;
  var domainList = <dynamic>[].obs;

  var locationName = ''.obs;
  var longitudes = ''.obs;
  var latitudes = ''.obs;
  var categorylist = <dynamic>[].obs;


  CategoryModel? categoryModel;
  var categroyid = ''.obs;
  var maxdistence = ''.obs;
  String? _Serchquery = '';

  void searchFilter(String search) {
    _Serchquery = search;
    domainList.value = domainList
        .where((item) =>
            item["title"].toLowerCase().contains(search.toLowerCase()))
        .toList();
    update();
  }

  Future<void> fetchDomainDetails(String categryid) async {
    try {
      isLoading(true);
      domainList.value.clear();
      print("----------pppppp---------$domainList");
      final response =
          await BaseClient.get(api: "${EndPoints.dominbyid}/$categryid");
      if (response != null && response.statusCode == 200) {
        var jsonResponse = response.data;
        domainList.value = jsonResponse['data'];
        print("----------pppppperrr---------$domainList");
      }
    } catch (e) {
      // Get.snackbar('Error', 'Failed to load domain details');
    } finally {
      isLoading(false);
    }
  }

  Future<void> mostviewfetchDomains() async {
    isLoading(true);
    try {
      domainList.value.clear();
      final response = await BaseClient.get(api: EndPoints.mostviewDomains);
      if (response != null && response.statusCode == 200) {
        var jsonResponse = response.data;
        domainList.value = jsonResponse['domains'] ?? [];
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCurrentLocationDetails() async {
    try {
      // Check for permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Handle permission denial
        return;
      }

      // Get current location
      final currentLocation = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final locations =
          LatLng(currentLocation.latitude, currentLocation.longitude);

// Center map on current location
      getPlaceName(locations.latitude, locations.longitude);
      update();
    } catch (e) {
      debugPrint("Failed to get current location: $e"); // Log the error message
    }
  }

  void getPlaceName(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    longitudes.value = longitude.toString();
    latitudes.value = latitude.toString();
    debugPrint("========long========> ${longitudes.value}${latitudes.value}");
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      debugPrint("${place.name}, ${place.locality}, ${place.country}");
      var location = "${place.name}, ${place.locality}, ${place.country}";
      locationName.value = location.toString();
      await LocalStore.saveLocation(location);
      var getLocation = await LocalStore.getLocation();

      debugPrint("Local Location get ====>$getLocation");
      update();
    }
  }

  Future<void> distencefetchDomains() async {
    isLoading(true);
    try {
      domainList.clear();
      getCurrentLocationDetails();
      final response = await BaseClient.get(
          api:
              "${EndPoints.distenceDomains}/${latitudes.value}/${longitudes.value}");
      if (response != null && response.statusCode == 200) {
        var jsonResponse = response.data;
        domainList.value = jsonResponse['domains'] ?? [];
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fillterdomin() async {
    try {
      isLoading(true);
      domainList.value.clear();
      final response = await BaseClient.get(
          api:
              "${EndPoints.filtterurl}?categoryId=${categroyid.value}&latitude=${latitudes.value}&latitude${longitudes.value}&maxDistance=${maxdistence.value}");

      if (response != null && response.statusCode == 200) {
        debugPrint("Response====>${response.data}");
        var jsonResponse = response.data;
        domainList.value = jsonResponse['data'];
        update();
      } else {}
    } catch (e) {
      debugPrint("Error =======$e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> getCategoryDat() async {
    try {
      final response = await BaseClient.get(api: EndPoints.allCategories);

      if (response != null && response.statusCode == 200) {
        debugPrint("Response====>${response.data}");
        var jsonResponse = response.data;
        categorylist.value = jsonResponse['category_list'];

        categoryModel = CategoryModel.fromJson(response.data);
        update();
      } else {}
    } catch (e) {
      debugPrint("Error =======$e");
    }
  }

  @override
  void onClose() {
    domainList.clear();
    // fetchDomainDetails();
    getCategoryDat();

    distencefetchDomains();
    distencefetchDomains(); // Clear the domain list when the controller is disposed
    super.onClose();
  }
}
