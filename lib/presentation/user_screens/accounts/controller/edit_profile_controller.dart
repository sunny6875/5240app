import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';

import 'package:image_picker/image_picker.dart';
import 'package:project_5240_frontend/data/client/baseclient/base_client.dart';
import 'package:project_5240_frontend/data/client/endpoints/endpoints.dart';
import 'package:project_5240_frontend/data/models/profile/profile_model.dart';
import 'package:project_5240_frontend/presentation/user_screens/accounts/controller/account_controller.dart';
// import 'package:project_5240_frontend/utils/extension.dart';
import 'package:http_parser/http_parser.dart';
import 'package:project_5240_frontend/utils/local_store.dart';

class EditProfileController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  // Controllers for the text fields
  RxString name = "".obs;
  RxString email = "".obs;
  // Image-related variables
  Rxn<File>? selectedImage = Rxn<File>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController =
      TextEditingController(text: "********************");

  // Observable variables to control the read/edit mode for full name and email
  RxBool isFullNameReadOnly = true.obs;
  RxBool isEmailReadOnly = true.obs;
  // Data Store
  ProfileModel? profileModel;
  // File for storing image
  File? _imageFile;
  String? get imageName =>
      _imageFile != null ? _imageFile?.path.split('/').last : "";
  // Pick image from gallery or camera
  Future<void> pickImage(ImageSource source) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image != null) {
      _imageFile = File(image.path);
      selectedImage!.value = File(image.path);
      update();
    }
  }

  // Toggle the read-only mode for full name
  void toggleFullNameEditMode() {
    isFullNameReadOnly.value = !isFullNameReadOnly.value;
    update();
  }

  // Toggle the read-only mode for email
  void toggleEmailEditMode() {
    // isEmailReadOnly.value = !isEmailReadOnly.value;
    isEmailReadOnly.value = true;
    update();
  }

  @override
  void onInit() {
    getUserLocalDetails();
    emailController.addListener(() {
      email.value = emailController.text;
    });
    fullNameController.addListener(() {
      name.value = fullNameController.text;
    });
    super.onInit();
  }

  getUserLocalDetails() async {
    name.value = (await LocalStore.getUserName())!;
    fullNameController.text = name.value;
    email.value = (await LocalStore.getUserEmail())!;
    emailController.text = email.value;
    update();
  }

// Getters for file and image details
  File? get imageFile => _imageFile;
  // Edit profile details and upload the image if available
  Future<bool> editProfile({String? userName, String? email}) async {
    isLoading.value = true;
    errorMessage.value = "";

    debugPrint("email===============>$email");
    debugPrint("name===============>$userName");
    // debugPrint("File name===============>${imageName}");
    update();
    try {
      final formData = FormData.fromMap({
        'userName': userName.toString().trim(),
        'userEmail': email.toString().trim(),
        if (_imageFile != null)
          'userProfile': [
            await MultipartFile.fromFile(_imageFile?.path ?? "",
                filename: imageName.toString(),
                contentType: MediaType('image', 'jpg')),
          ]
      });

      final response = await BaseClient.put(
        api: EndPoints.UPDATEPROFILE,
        formData: formData,
      );

      if (response != null && response.statusCode == 200) {
        _handleSuccessResponse(response.data);
        debugPrint("Profile updated successfully! ${response.data}");
        isLoading.value = false;
        _imageFile = null;
        update();
        return true;
      } else {
        errorMessage.value = response.data['message'];
        return false;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred. Please try again.';
      debugPrint("Error: $e");
      return false;
    } finally {
      isLoading.value = false;
      update();
    }
  }

  void _handleSuccessResponse(Map<String, dynamic> data) async {
    Fluttertoast.showToast(msg: "Profile updated successfully!");
    debugPrint("Response:=====================> $data");

    // debugPrint("Model Data:====> ${profileModel!.user}");
    final userName = data["user"]["userName"] ?? "";
    final userEmail = data["user"]["userEmail"] ?? "";

    debugPrint("-------Remote user Data----");
    debugPrint("userName======>$userName");
    debugPrint("userEmail======>$userEmail");

    await LocalStore.updateUserData(
      userName: userName,
      email: userEmail,
    );

    debugPrint("-------Local user Data----");
    String? localEmail = await LocalStore.getUserEmail();
    String? localFirstName = await LocalStore.getUserName();

    debugPrint("Local Email=====>$localEmail");

    debugPrint("localFirstName ===>$localFirstName");

    debugPrint("Profile data updated locally.");

    final acounController = Get.find<AccountController>();
    acounController.getProfileData();
    acounController.getUserLocalDetails();
    getUserLocalDetails();
    update();
  }

// Function to check if the passwords match
  bool get isPasswordsMatch => name.value.isNotEmpty && email.value.isNotEmpty;

  // Validate form and submit the profile update
  Future<void> updateProfileBtn() async {
    if (isPasswordsMatch) {
      final success = await editProfile(
        userName: name.value,
        email: email.value,
      );

      if (!success) {
        Fluttertoast.showToast(
          msg: errorMessage.value.isNotEmpty
              ? errorMessage.value
              : 'Please check your internet connection',
          backgroundColor: Colors.red,
        );
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    fullNameController.dispose();
    super.dispose();
  }
}
