// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/state_manager.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:project_5240_frontend/utils/local_store.dart';
import '../../../../data/client/baseclient/base_client.dart';

class AddSubDomainController extends GetxController {
  var pickedImagesList = <File>[].obs;
  final ImagePicker _picker = ImagePicker();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  //Drop down
  var selectedItem = ''.obs;

  // Function to set selected item
  void setSelectedItem(String value) {
    selectedItem(value);
  }

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImagesList.add(File(pickedFile.path));
    }
  }

  // Pick image from camera
  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      pickedImagesList.add(File(pickedFile.path));
    }
  }

  void removeImageWithIndex(index) {
    pickedImagesList.removeAt(index);
    update();
  }

  // Submit data to API
  Future<bool?> addDomainData({
    String? title,
    String? status,
    String? description,
    List? basicItem1Id,
    List? basicItem2Id,
  }) async {
    final domainId = await LocalStore.getdominid();
    isLoading.value = true;
    update();
    // Prepare the image files as MultipartFile
    List<MultipartFile> imageFiles = await Future.wait(
      pickedImagesList.map((file) async {
        return await MultipartFile.fromFile(
          file.path,
          filename: basename(file.path), // Extract file name from the path
        );
      }).toList(),
    );

    // Construct the FormData with images and other form fields
    FormData formData = FormData.fromMap({
      'title': title,
      'status': 'active',
      'description': description,
      'basicItem1Id': basicItem1Id,
      'basicItem2Id': basicItem2Id,
      "image": imageFiles,
    });
    debugPrint("title=============>$title");
    debugPrint("description=============>$description");
    debugPrint("basicItem1Id=============>$basicItem1Id");
    debugPrint("basicItem2Id=============>$basicItem2Id");
    debugPrint("imageFiles=============>${imageFiles.first.filename}");
    debugPrint("================>/api/domains/$domainId/subdomain");
    try {
      final response = await BaseClient.post(
          api: "/api/domains/$domainId/subdomain", formData: formData);
      debugPrint("Response====>${response.data}");
      if (response != null && response.statusCode == 201) {
        debugPrint("Response====>${response.data}");
        errorMessage.value = response.data['message'];

        isLoading.value = false;

        Fluttertoast.showToast(msg: errorMessage.value);
        update();
        return true;
      } else {
        Fluttertoast.showToast(msg: response.data['message']);
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
}
