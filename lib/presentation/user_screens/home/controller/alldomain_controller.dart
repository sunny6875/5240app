import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import '../../../../utils/extension.dart';

class DomainController extends GetxController {
  var domainList = <dynamic>[].obs; // Observable list for domains

  var isLoading = false.obs;
  RxString? currentLocation = "Choose your location".obs;

  @override
  void onInit() {
    super.onInit();
    fetchDomains();
    getCurrentLocationDetails();
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

      // Get place name and save it
      getPlaceName(locations.latitude, locations.longitude);
    } catch (e) {
      debugPrint("Failed to get current location: $e");
    }
  }

  // Get place name from latitude and longitude and store it in SharedPreferences
  void getPlaceName(double latitude, double longitude) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      var location = "${place.name}, ${place.locality}, ${place.country}";

      // Save location to SharedPreferences
      await LocalStore.saveLocation(location);

      // Retrieve saved location
      var getLocation = await LocalStore.getLocation();
      currentLocation!.value = getLocation ?? location;
      update();
    }
  }

  void updateLocationManually(String newLocation) async {
    await LocalStore.saveLocation(newLocation);
    var savedLocation = await LocalStore.getLocation();
    currentLocation!.value = savedLocation ?? newLocation;
    update();
  }


  Future<void> fetchDomains() async {
    isLoading(true);
    try {
      final response = await BaseClient.get(api: EndPoints.allDomains);

      if (response != null && response.statusCode == 200) {
        var jsonResponse = response.data;
        // domainList = Alldomain.fromJson(response.data);

        debugPrint(
            "-------------------------------------${jsonResponse['domains']}");
        domainList.value = jsonResponse['domains'] ?? [];
      } else {
        // Handle error if response is not successful
        Get.snackbar(
          'Error',
          'Failed to load domains',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print("Error fetching domains");
      }
    } catch (e) {
      print('Error: $e');
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: const Center(child: Text('Error')),
            contentPadding: const EdgeInsets.all(20),
            children: [
              Text(
                e.toString(),
              ),
            ],
          );
        },
      );
    } finally {
      isLoading(false);
    }
  }
}
