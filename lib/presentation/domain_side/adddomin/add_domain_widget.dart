// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/data/models/provider_side_model/category_model.dart';
import 'package:project_5240_frontend/presentation/domain_side/componets/custom_circle_progressbar.dart';
import 'package:project_5240_frontend/presentation/domain_side/componets/custom_textview.dart';
import 'package:project_5240_frontend/presentation/user_screens/home/navigation_bar.dart';
import 'controller/add_domain_controller.dart';

// ignore: must_be_immutable
class AddDomainWidget extends StatelessWidget {
  bool? afterLoginAddDomain;
  AddDomainWidget({this.afterLoginAddDomain}) : super();
  AddDomainController controller = Get.put(AddDomainController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDomainController>(builder: (controller) {
      return Scaffold(
        body: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: const EdgeInsets.only(
                top: 90,
                bottom: 60,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Container(
                    height: 5,
                    width: 50,
                    decoration: const BoxDecoration(
                      color: AppColors.blackText,
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const CustomTextView(
                    "Add Domain ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 5),
                  const CustomTextView(
                    "Name and location of your domain",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 40),
                  Obx(() {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color.fromRGBO(240, 245, 250, 1),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide
                                .none, // Remove the border when enabled
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide
                                .none, // Remove the border when focused
                          ),
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                        ),
                        focusColor: AppColors.black,
                        isExpanded: true,
                        value: controller.selectedItem.value.isEmpty
                            ? null
                            : controller.selectedItem.value,
                        hint: const Text(
                          'Select an item',
                          style: TextStyle(
                            fontFamily: "inter",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        onChanged: (newValue) {
                          controller.setSelectedItem(newValue!);
                        },
                        items: controller.categoryModel?.categoryList
                                ?.map<DropdownMenuItem<String>>(
                                    (CategoryList value) {
                              return DropdownMenuItem<String>(
                                value: value.sId ?? '',
                                child: Text(value.categoryName ?? ''),
                              );
                            }).toList() ??
                            [],
                      ),
                    );
                  }),
                  const SizedBox(height: 20),
                  customTextField(
                    controller: controller.titleController,
                    onChanged: (value) => controller.title.value = value,
                    title: "Name",
                  ),
                  const SizedBox(height: 20),
                  customTextField(
                    controller: controller.addressController,
                    onChanged: (value) => controller.address.value = value,
                    title: "Address",
                    readOnly: true,
                    suffixIcon: controller.isLoadingAddress.value
                        ? const CustomCircleProgressbar(
                            radius: 10,
                          )
                        : IconButton(
                            icon: const Icon(Icons.location_on_outlined),
                            onPressed: () {
                              controller.getCurrentLocationDetails();
                            },
                          ),
                  ),
                  const SizedBox(height: 20),
                  customTextField(
                    controller: controller.openingTimeController,
                    onChanged: (value) => controller.openTime.value = value,
                    title: "Opening Time",
                    readOnly: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.av_timer_outlined),
                      onPressed: () async {
                        controller.openingTimeController.text =
                            (await controller.selectTime())!;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  customTextField(
                    controller: controller.closingTimeController,
                    onChanged: (value) => controller.closeTime.value = value,
                    title: "Closing Time",
                    readOnly: true,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.av_timer_outlined),
                      onPressed: () async {
                        controller.closingTimeController.text =
                            (await controller.selectTime())!;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  customTextField(
                    controller: controller.descriptionController,
                    onChanged: (value) => controller.description.value = value,
                    title: "Description",
                  ),
                  const SizedBox(height: 20),
                  uploadPhotosWidget(),
                  const SizedBox(height: 40),
                  btnWidget(),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget customTextField(
      {String? title,
      String? hintText,
      bool readOnly = false,
      Widget? suffixIcon,
      void Function()? onTap,
      void Function(String)? onChanged,
      TextEditingController? controller}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextView(
            (title!.toUpperCase()),
            style: const TextStyle(fontSize: 15, color: AppColors.black),
          ),
          const SizedBox(height: 10),
          TextField(
            onTap: onTap,
            controller: controller,
            onChanged: onChanged,
            readOnly: readOnly,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              filled: true,
              fillColor: const Color.fromRGBO(240, 245, 250, 1),
              hintText: hintText ?? "",
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget uploadPhotosWidget() {
    return GetBuilder<AddDomainController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomTextView(
              "UPLOAD DOMAIN PHOTOS",
              style: TextStyle(fontSize: 14, color: AppColors.black),
            ),
            const SizedBox(height: 20),
            Obx(
              () => GridView.builder(
                itemCount:
                    controller.pickedImages.length + 1, // +1 for the add button
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5, // Number of items per row
                  mainAxisSpacing: 16,

                  crossAxisSpacing: 10,
                  mainAxisExtent: 80,
                ),
                itemBuilder: (BuildContext context, int index) {
                  // Check if it's the last index (reserved for the Add button)
                  if (index == controller.pickedImages.length) {
                    // Calculate the position for the 'Add' button to be at the end
                    return Padding(
                      padding: EdgeInsets.only(
                          left: index % 5 == 4
                              ? 0
                              : 4), // Adjust padding for alignment
                      child: GestureDetector(
                        onTap: () async {
                          // Image picker logic here
                          controller.pickImageFromGallery();
                        },
                        child: Container(
                          height: 111,
                          width: 101,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[300],
                          ),
                          child: Icon(
                            Icons.add,
                            size: 40,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    );
                  }

                  // For other items (existing images)
                  return Stack(
                    children: [
                      Container(
                        height: 88,
                        width: 101,
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.lighGrey,
                          image: DecorationImage(
                            image: FileImage(controller
                                .pickedImages[index]), // Display picked images
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      InkWell(
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            height: 25,
                            width: 25,
                            decoration: BoxDecoration(
                                color: AppColors.starRedColor.withOpacity(0.4),
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.close_outlined,
                              size: 16,
                              color: AppColors.starRedColor,
                            ),
                          ),
                        ),
                        onTap: () => controller.removeImageWithIndex(index),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget btnWidget() {
    return Obx(() => GestureDetector(
          onTap: () {
            if (controller.validateForm()) {
              controller.submitData().then((value) {
                if (value == true) {
                  if (afterLoginAddDomain == true) {
                    Get.back();
                  } else {
                    Get.off(const HomeScreen());
                  }
                }
              });
            }
          },
          child: Container(
            width: Get.size.width,
            margin: const EdgeInsets.symmetric(horizontal: 25),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: const Color(0xff32B768),
              borderRadius: BorderRadius.circular(15),
            ),
            child: controller.isLoading.value
                ? const NutsActivityIndicator(
                    activeColor: Colors.white,
                    inactiveColor: AppColors.green,
                    tickCount: 24,
                    relativeWidth: 0.4,
                    radius: 10,
                    startRatio: 0.7,
                    animationDuration: Duration(milliseconds: 500),
                  )
                : const Text(
                    'Continue',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
          ),
        ));
  }
}
