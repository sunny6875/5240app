// // ignore_for_file: depend_on_referenced_packages, override_on_non_overriding_member
//
// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
//
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:project_5240_frontend/data/models/provider_side_model/category_model.dart';
// import 'dart:io';
//
// import '../../../../data/client/baseclient/base_client.dart';
// import '../../../../data/client/endpoints/endpoints.dart';
// import 'package:path/path.dart';
//
// import '../../../../utils/local_store.dart';
//
// class AddDomainController extends GetxController {
//   var title = ''.obs;
//   var description = ''.obs;
//   var address = ''.obs;
//   var openTime = ''.obs;
//   var closeTime = ''.obs;
//   var locationName = ''.obs;
//   var longitudes = ''.obs;
//   var latitudes = ''.obs;
//   var pickedImages = <File>[].obs;
//   String? savedToken;
//   final ImagePicker _picker = ImagePicker();
//   RxBool isLoading = false.obs;
//   RxBool isLoadingAddress = false.obs;
//   RxString errorMessage = ''.obs;
//   CategoryModel? categoryModel;
//   TextEditingController titleController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController openingTimeController = TextEditingController();
//   TextEditingController closingTimeController = TextEditingController();
//   TextEditingController descriptionController = TextEditingController();
//   TimeOfDay selectedTime = TimeOfDay.now();
//   //Drop down
//   var selectedItem = ''.obs; // Selected item observable
//
//   // Function to set selected item
//   void setSelectedItem(String value) {
//     selectedItem(value);
//   }
//
//   removeImageWithIndex(index) {
//     pickedImages.removeAt(index);
//     update();
//   }
//
//   @override
//
//   // Pick image from gallery
//   Future<void> pickImageFromGallery() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//     if (pickedFile != null) {
//       pickedImages.add(File(pickedFile.path));
//     }
//   }
//
//   // Pick image from camera
//   Future<void> pickImageFromCamera() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.camera);
//     if (pickedFile != null) {
//       pickedImages.add(File(pickedFile.path));
//     }
//   }
//
//   Future<String?> selectTime() async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: Get.context!,
//       initialTime: selectedTime,
//     );
//
//     if (picked != null && picked != selectedTime) {
//       selectedTime = picked;
//       debugPrint("Time===${selectedTime.format(Get.context!)}");
//       return selectedTime.format(Get.context!);
//     }
//     return null;
//   }
//
//   Future<void> getCurrentLocationDetails() async {
//     isLoadingAddress.value = true;
//     update();
//     try {
//       // Check for permission
//       LocationPermission permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//       }
//
//       if (permission == LocationPermission.denied ||
//           permission == LocationPermission.deniedForever) {
//         // Handle permission denial
//         return;
//       }
//
//       // Get current location
//       final currentLocation = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       final locations =
//           LatLng(currentLocation.latitude, currentLocation.longitude);
//
// // Center map on current location
//       getPlaceName(locations.latitude, locations.longitude);
//       isLoadingAddress.value = false;
//       update();
//     } catch (e) {
//       debugPrint("Failed to get current location: $e"); // Log the error message
//     }
//   }
//
//   void getPlaceName(double latitude, double longitude) async {
//     List<Placemark> placemarks =
//         await placemarkFromCoordinates(latitude, longitude);
//     longitudes.value = longitude.toString();
//     latitudes.value = latitude.toString();
//     debugPrint("========long========> ${longitudes.value}${latitudes.value}");
//     if (placemarks.isNotEmpty) {
//       Placemark place = placemarks.first;
//       debugPrint("${place.name}, ${place.locality}, ${place.country}");
//       var location = "${place.name}, ${place.locality}, ${place.country}";
//       locationName.value = location.toString();
//       addressController.text = locationName.value;
//       await LocalStore.saveLocation(location);
//       var getLocation = await LocalStore.getLocation();
//
//       debugPrint("Local Location get ====>$getLocation");
//       debugPrint("Location get  ====>${address.value}");
//       update();
//     }
//   }
//
//   // Submit data to API
//   Future<bool?> addDomainData(
//       {String? title,
//       String? status,
//       String? locationName,
//       String? long,
//       String? lati,
//       String? categoryId,
//       String? description,
//       String? openingTime,
//       String? closingTime}) async {
//     isLoading.value = true;
//     update();
//     // Prepare the image files as MultipartFile
//     List<MultipartFile> imageFiles = await Future.wait(
//       pickedImages.map((file) async {
//         return await MultipartFile.fromFile(
//           file.path,
//           filename: basename(file.path), // Extract file name from the path
//         );
//       }).toList(),
//     );
//
//     debugPrint("=================>${imageFiles.length}");
//     debugPrint("Category Id =================>${selectedItem.value}");
//     // Construct the FormData with images and other form fields
//     FormData formData = FormData.fromMap({
//       'title': title,
//       'status': status,
//       'location[name]': locationName,
//       'location[longitude]': long,
//       'location[latitude]': lati,
//       'categoryId': categoryId,
//       'description': description,
//       'image': imageFiles, // Add the list of image files
//       "opening": openingTime,
//       "closing": closingTime,
//     });
//     try {
//       final response =
//           await BaseClient.post(api: EndPoints.allDomains, formData: formData);
//
//       if (response != null && response.statusCode == 201) {
//         debugPrint("Response====>${response.data}");
//         errorMessage.value = response.data['message'];
//
//         var domindid = response.data['domain']['_id'];
//         LocalStore.savedominid(domindid);
//
//         Fluttertoast.showToast(msg: errorMessage.value);
//         isLoading.value = false;
//         Future.delayed(const Duration(milliseconds: 200), () {
//           titleController.clear();
//           descriptionController.clear();
//           addressController.clear();
//           openingTimeController.clear();
//           closingTimeController.clear();
//           selectedItem = "".obs;
//           pickedImages.clear();
//           update();
//         });
//
//         update();
//         return true;
//       } else {
//         Get.snackbar('Error', 'Failed to add domain');
//         Fluttertoast.showToast(msg: "Failed to add domain");
//         isLoading.value = false;
//         update();
//         return false;
//       }
//     } catch (e) {
//       debugPrint('Error An error occurred: $e');
//       isLoading.value = false;
//       update();
//       return false;
//     }
//   }
//
//   Future<bool> submitData() async {
//     // Check input values
//     debugPrint(
//         "Submitting Data: Title - ${title.value}, Description - ${description.value}");
//
//     try {
//       // Call the addDomainData API
//       final success = await addDomainData(
//         title: title.value,
//         status: "active",
//         description: description.value,
//         locationName: locationName.value,
//         lati: latitudes.value, // Changed to latitudes instead of longitudes
//         long: longitudes.value,
//         categoryId: selectedItem.value,
//         openingTime: openingTimeController.text,
//         closingTime: closingTimeController.text,
//       );
//
//       // Check if the submission was successful
//       if (success == true) {
//         debugPrint("Data uploaded successfully");
//         update(); // Update UI
//         return true;
//       } else {
//         debugPrint("Data upload failed: ${errorMessage.value}");
//         return false;
//       }
//     } catch (e) {
//       // Catch any errors and print them
//       debugPrint("An error occurred during submission: $e");
//       return false;
//     }
//   }
//
//   Future<void> getCategoryDat() async {
//     try {
//       final response = await BaseClient.get(api: EndPoints.allCategories);
//
//       if (response != null && response.statusCode == 200) {
//         debugPrint("Response====>${response.data}");
//         categoryModel = CategoryModel.fromJson(response.data);
//         update();
//       } else {
//         Get.snackbar('Error', 'Failed to get category');
//       }
//     } catch (e) {
//       debugPrint("Error =======$e");
//     }
//   }
//
// // Validation method
//   bool validateForm() {
//     if (titleController.text.isEmpty ||
//         addressController.text.isEmpty ||
//         openingTimeController.text.isEmpty ||
//         closingTimeController.text.isEmpty ||
//         descriptionController.text.isEmpty ||
//         pickedImages.isEmpty) {
//       Fluttertoast.showToast(
//           msg: 'Please fill all the fields and pick at least one image.');
//       return false;
//     }
//     return true;
//   }
//
//   @override
//   void onInit() {
//     getCurrentLocationDetails();
//     getCategoryDat();
//     super.onInit();
//   }
// }
// ignore_for_file: depend_on_referenced_packages, override_on_non_overriding_member

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:project_5240_frontend/data/models/provider_side_model/category_model.dart';
import 'dart:io';

import '../../../../data/client/baseclient/base_client.dart';
import '../../../../data/client/endpoints/endpoints.dart';
import 'package:path/path.dart';

import '../../../../utils/local_store.dart';

class AddDomainController extends GetxController {
  var title = ''.obs;
  var description = ''.obs;
  var address = ''.obs;
  var openTime = ''.obs;
  var closeTime = ''.obs;
  var locationName = ''.obs;
  var longitudes = ''.obs;
  var latitudes = ''.obs;
  var pickedImages = <File>[].obs;
  String? savedToken;
  final ImagePicker _picker = ImagePicker();
  RxBool isLoading = false.obs;
  RxBool isLoadingAddress = false.obs;
  RxString errorMessage = ''.obs;
  CategoryModel? categoryModel;
  TextEditingController titleController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController openingTimeController = TextEditingController();
  TextEditingController closingTimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TimeOfDay selectedTime = TimeOfDay.now();
  //Drop down
  var selectedItem = ''.obs; // Selected item observable

  // Function to set selected item
  void setSelectedItem(String value) {
    selectedItem(value);
  }

  removeImageWithIndex(index) {
    pickedImages.removeAt(index);
    update();
  }

  @override

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImages.add(File(pickedFile.path));
    }
  }

  // Pick image from camera
  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      pickedImages.add(File(pickedFile.path));
    }
  }

  Future<String?> selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: Get.context!,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      debugPrint("Time===${selectedTime.format(Get.context!)}");
      return selectedTime.format(Get.context!);
    }
    return null;
  }

  Future<void> getCurrentLocationDetails() async {
    isLoadingAddress.value = true;
    update();
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
      isLoadingAddress.value = false;
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
      addressController.text = locationName.value;
      await LocalStore.saveLocation(location);
      var getLocation = await LocalStore.getLocation();

      debugPrint("Local Location get ====>$getLocation");
      debugPrint("Location get  ====>${address.value}");
      update();
    }
  }

  // Submit data to API
  Future<bool?> addDomainData(
      {String? title,
        String? status,
        String? locationName,
        String? long,
        String? lati,
        String? categoryId,
        String? description,
        String? openingTime,
        String? closingTime}) async {
    isLoading.value = true;
    update();
    // Prepare the image files as MultipartFile
    List<MultipartFile> imageFiles = await Future.wait(
      pickedImages.map((file) async {
        return await MultipartFile.fromFile(
          file.path,
          filename: basename(file.path), // Extract file name from the path
        );
      }).toList(),
    );

    debugPrint("=================>${imageFiles.length}");
    debugPrint("Category Id =================>${selectedItem.value}");
    debugPrint("Opening Time: $openingTime, Closing Time: $closingTime");

    // Construct the FormData with images and other form fields
    FormData formData = FormData.fromMap({
      'title': title,
      'status': status,
      'location[name]': locationName,
      'location[longitude]': long,
      'location[latitude]': lati,
      'categoryId': categoryId,
      'description': description,
      'image': imageFiles, // Add the list of image files
      "opening": openingTime,
      "closing": closingTime, // Make sure this matches what the backend expects
    });
    try {
      final response =
      await BaseClient.post(api: EndPoints.allDomains, formData: formData);

      if (response != null && response.statusCode == 201) {
        debugPrint("Response====>${response.data}");
        errorMessage.value = response.data['message'];

        var domindid = response.data['domain']['_id'];
        LocalStore.savedominid(domindid);

        Fluttertoast.showToast(msg: errorMessage.value);
        isLoading.value = false;
        Future.delayed(const Duration(milliseconds: 200), () {
          titleController.clear();
          descriptionController.clear();
          addressController.clear();
          openingTimeController.clear();
          closingTimeController.clear();
          selectedItem = "".obs;
          pickedImages.clear();
          update();
        });

        update();
        return true;
      } else {
        Get.snackbar('Error', 'Failed to add domain');
        Fluttertoast.showToast(msg: "Failed to add domain");
        isLoading.value = false;
        update();
        return false;
      }
    } catch (e) {
      debugPrint('Error An error occurred: $e');
      isLoading.value = false;
      update();
      return false;
    }
  }

  Future<bool> submitData() async {
    // Check input values
    debugPrint(
        "Submitting Data: Title - ${title.value}, Description - ${description.value}, Opening - ${openingTimeController.text}, Closing - ${closingTimeController.text}");

    try {
      // Call the addDomainData API
      final success = await addDomainData(
        title: title.value,
        status: "active",
        description: description.value,
        locationName: locationName.value,
        lati: latitudes.value,
        long: longitudes.value,
        categoryId: selectedItem.value,
        openingTime: openingTimeController.text, // Correct value
        closingTime: closingTimeController.text, // Ensure this is passed correctly
      );

      // Check if the submission was successful
      if (success == true) {
        debugPrint("Data uploaded successfully");
        update(); // Update UI
        return true;
      } else {
        debugPrint("Data upload failed: ${errorMessage.value}");
        return false;
      }
    } catch (e) {
      // Catch any errors and print them
      debugPrint("An error occurred during submission: $e");
      return false;
    }
  }

  Future<void> getCategoryDat() async {
    try {
      final response = await BaseClient.get(api: EndPoints.allCategories);

      if (response != null && response.statusCode == 200) {
        debugPrint("Response====>${response.data}");
        categoryModel = CategoryModel.fromJson(response.data);
        update();
      } else {
        Get.snackbar('Error', 'Failed to get category');
      }
    } catch (e) {
      debugPrint("Error =======$e");
    }
  }

  // Validation method
  bool validateForm() {
    if (titleController.text.isEmpty ||
        addressController.text.isEmpty ||
        openingTimeController.text.isEmpty ||
        closingTimeController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        pickedImages.isEmpty) {
      Fluttertoast.showToast(msg: "Please fill all required fields");
      return false;
    }
    return true;
  }
  @override
  void onInit() {
    getCurrentLocationDetails();
    getCategoryDat();
    super.onInit();
  }
}
