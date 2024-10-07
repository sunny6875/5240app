import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_instance/src/extension_instance.dart';

import 'package:get/state_manager.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_5240_frontend/data/models/provider_side_model/category_model.dart';
import 'package:path/path.dart';
import 'package:project_5240_frontend/presentation/domain_side/domin_home/controller/dominhome_controller.dart';
import 'package:project_5240_frontend/utils/local_store.dart';
import '../../../../data/client/baseclient/base_client.dart';

class EditDomainController extends GetxController {
  var title = ''.obs;

  var pickedImages = <File>[].obs;
  String? savedToken;
  final ImagePicker _picker = ImagePicker();
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  CategoryModel? categoryModel;
  TextEditingController titleController = TextEditingController();
  DomainidController controller = Get.put(DomainidController());
  //Drop down
  var selectedItem = ''.obs; // Selected item observable

  // Function to set selected item
  void setSelectedItem(String value) {
    selectedItem(value);
  }

  getUserLocalDetails() {
    titleController = TextEditingController(
        text: controller.domainModel.value?.domain?.title ?? "");
    update();
  }

  removeImageWithIndex(index) {
    pickedImages.removeAt(index);
    update();
  }

  // Pick image from gallery
  Future<void> pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImages.add(File(pickedFile.path));
    }
  }

  // Submit data to API
  Future<bool?> editDomain({String? title}) async {
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
    debugPrint("=================>$title");

    FormData formData = FormData.fromMap({
      'title': title,
      'image': imageFiles, // Add the list of image files
    });
    final domainId = await LocalStore.getdominid();
    try {
      final response = await BaseClient.put(
          api: "/api/domains/$domainId", formData: formData);

      if (response != null && response.statusCode == 200) {
        debugPrint("Response====>${response.data}");
        errorMessage.value = response.data['message'];

        Fluttertoast.showToast(msg: errorMessage.value);
        isLoading.value = false;
        controller.fetchDomain();
        pickedImages.clear();
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

  @override
  onInit() {
    super.onInit();
    getUserLocalDetails();
  }
}
