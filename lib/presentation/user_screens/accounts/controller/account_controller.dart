import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_5240_frontend/data/models/profile/profile_model.dart';
import 'package:project_5240_frontend/presentation/user_screens/details/controller/details_controller.dart';
import 'package:project_5240_frontend/utils/extension.dart';

class AccountController extends GetxController {
  RxString name = "".obs;
  RxString email = "".obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  ProfileModel? profileModel;
  RxString? currentLocation = "".obs;

  @override
  void onInit() {
    getProfileData();
    getUserLocalDetails();
    getCurrentLocationDetails();
    super.onInit();
  }

  getUserLocalDetails() async {
    name.value = (await LocalStore.getUserName())!;
    email.value = (await LocalStore.getUserEmail())!;
  }

  // Handle login logic with API request
  Future<void> getProfileData() async {
    isLoading.value = true;
    errorMessage.value = '';
    update();
    try {
      final response = await BaseClient.get(api: EndPoints.GETPROFILE);
      if (response != null && response.statusCode == 200) {
        profileModel = ProfileModel.fromJson(response.data);
        debugPrint("Profile Data : ${profileModel?.user}");
        debugPrint(
            "isDomainAdded in Profile  : ${profileModel?.user?.isDomainAdded}");

        // for like functionality
        final controller = Get.find<DetailsController>();
        controller.addSavedCollectionIds(profileModel?.user?.likedDomains);
        isLoading.value = false;
        update();
      } else {
        isLoading.value = false;
        update();
      }
    } catch (e) {
      errorMessage.value = 'please check internet connection..';
      isLoading.value = false;
      update();
    }
  }

  submit() {}
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

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks.first;
      debugPrint("${place.name}, ${place.locality}, ${place.country}");
      var location = "${place.locality}, ${place.country}";
      await LocalStore.saveLocation(location);
      var getLocation = await LocalStore.getLocation();
      debugPrint("Local Location get ====>$getLocation");
      currentLocation!.value = getLocation ?? location;
      update();
    }
  }
}
