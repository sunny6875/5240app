// ignore_for_file: unnecessary_overrides

import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_5240_frontend/utils/extension.dart';

class MapControllerX extends GetxController {
  var mapController = Rx<MapController>(MapController());
  var center = const LatLng(20.5937, 78.9629).obs; // Initial center
  RxBool centerLocationForZoom = false.obs; // Initial center
  var currentZoom = 4.0.obs; // Initial zoom level
  var currentPosition = Rx<Position?>(null); // Current position
  var isLoading = false.obs; // Loading state
  RxString locationName = "".obs;

  @override
  void onInit() {
    getCurrentLocation();
    super.onInit();
  }

  void moveTo(LatLng latLng) {
    mapController.value.move(latLng, currentZoom.value);
  }

  void zoomIn() {
    if (currentZoom.value < 16) {
      currentZoom.value++;
    }
    debugPrint("Max Increase==========>${currentZoom.value}");
    mapController.value.move(center.value, currentZoom.value);
  }

  void zoomOut() {
    if (currentZoom.value > 3) {
      currentZoom.value--;
    }
    debugPrint("Min Descriase==========>${currentZoom.value}");
    mapController.value.move(center.value, currentZoom.value);
  }

  Future<void> getCurrentLocation() async {
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
      isLoading.value = true; // Loading state
      update();
      // Get current location
      currentPosition.value = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      center.value = LatLng(
          currentPosition.value!.latitude, currentPosition.value!.longitude);

      mapController.value.move(
          center.value, currentZoom.value); // Center map on current location
      getPlaceName(center.value.latitude, center.value.longitude);
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false; // Set loading to false in case of an error
      debugPrint("Failed to get current location: $e"); // Log the error message
      update();
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
      isLoading.value = true; // Loading state
      update();
      // Get current location
      currentPosition.value = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      center.value = LatLng(
          currentPosition.value!.latitude, currentPosition.value!.longitude);
      centerLocationForZoom.value = true;
      mapController.value.move(
          center.value, currentZoom.value); // Center map on current location
      getPlaceName(center.value.latitude, center.value.longitude);
      isLoading.value = false;
      update();
    } catch (e) {
      isLoading.value = false; // Set loading to false in case of an error
      debugPrint("Failed to get current location: $e"); // Log the error message
      update();
    }
  }

  void getPlaceName(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      debugPrint("${place.name}, ${place.locality}, ${place.country}");
      final location = "${place.name}, ${place.locality}, ${place.country}";
      await LocalStore.saveLocation(location);
      var getLocation = await LocalStore.getLocation();
      debugPrint("Local Location get ====>$getLocation");
      locationName.value = getLocation ?? "";
    }
  }
}
