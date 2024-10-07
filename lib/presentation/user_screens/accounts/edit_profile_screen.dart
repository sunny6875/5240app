import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/presentation/user_screens/accounts/controller/account_controller.dart';
import 'package:project_5240_frontend/presentation/user_screens/accounts/controller/edit_profile_controller.dart';
import '../forget_password/change_password/change_password_screen.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final EditProfileController editProfileController =
      Get.put(EditProfileController());
  final AccountController accountController = Get.find<AccountController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Obx(
        () => GestureDetector(
          onTap: () {
            editProfileController.updateProfileBtn();
          },
          child: editProfileController.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.only(bottom: 80),
                  child: NutsActivityIndicator(
                    activeColor: Colors.white,
                    inactiveColor: AppColors.green,
                    tickCount: 24,
                    relativeWidth: 0.4,
                    radius: 20,
                    startRatio: 0.7,
                    animationDuration: Duration(milliseconds: 500),
                  ),
                )
              : Container(
                  margin:
                      const EdgeInsets.only(bottom: 40, left: 30, right: 30),
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: editProfileController.isPasswordsMatch
                        ? const Color.fromRGBO(50, 183, 104, 1)
                        : const Color.fromRGBO(244, 244, 244, 1),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Text(
                    'Update Profile',
                    style: TextStyle(
                      color: !editProfileController.isPasswordsMatch
                          ? Colors.black
                          : const Color.fromRGBO(244, 244, 244, 1),
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Obx(
          () => IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: editProfileController.isLoading.value
                ? null
                : () {
                    Navigator.pop(context);
                    editProfileController.getUserLocalDetails();
                  },
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Bio-data',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xff181D27)),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 35, right: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: Obx(() {
                  return GestureDetector(
                    onTap: () {
                      _showImageSourceActionSheet(
                          context, editProfileController);
                    },
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          editProfileController.selectedImage?.value != null
                              ? FileImage(
                                  editProfileController.selectedImage!.value!)
                              : CachedNetworkImageProvider(accountController
                                      .profileModel?.user?.userProfile ??
                                  "") as ImageProvider,
                      child:
                          (editProfileController.selectedImage?.value == null &&
                                  accountController
                                          .profileModel?.user?.userProfile ==
                                      null)
                              ? CachedNetworkImage(
                                  imageUrl:
                                      "https://cdn-icons-png.flaticon.com/128/4140/4140037.png",
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.person),
                                )
                              : null,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 60),
              Obx(() => _customTextField(
                    controller: editProfileController.fullNameController,
                    title: "Full Name",
                    readOnly: editProfileController.isFullNameReadOnly.value,
                    readOnlyTap: editProfileController.toggleFullNameEditMode,
                  )),
              const SizedBox(height: 40),
              Obx(() => _customTextField(
                    controller: editProfileController.emailController,
                    title: "Your Email",
                    readOnly: editProfileController.isEmailReadOnly.value,
                    readOnlyTap: editProfileController.toggleEmailEditMode,
                  )),
              const SizedBox(height: 40),
              _customTextField(
                controller: editProfileController.passwordController,
                title: "Update Password",
                readOnlyTap: () {
                  Get.to(ChangePasswordScreen());
                },
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customTextField({
    String? title,
    TextEditingController? controller,
    bool readOnly = true,
    void Function()? readOnlyTap,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title ?? "",
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff374151)),
            ),
            GestureDetector(
              onTap: readOnlyTap,
              child: !readOnly
                  ? const Icon(Icons.edit_outlined, size: 20)
                  : SvgPicture.asset('assets/svg_icons/edit_.svg'),
            ),
          ],
        ),
        TextField(
          controller: controller,
          readOnly: readOnly,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 10),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
      ],
    );
  }

  void _showImageSourceActionSheet(BuildContext context, profileController) {
    showModalBottomSheet(
        backgroundColor: AppColors.white,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Photo Library'),
                    onTap: () {
                      profileController.pickImage(ImageSource.gallery);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Camera'),
                  onTap: () {
                    profileController.pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}
