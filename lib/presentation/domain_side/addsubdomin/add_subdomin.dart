import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:project_5240_frontend/presentation/domain_side/addsubdomin/controller/add_subdomin_controller.dart';
import 'package:project_5240_frontend/presentation/domain_side/addsubdomin/controller/basicitem_controller.dart';
import 'package:project_5240_frontend/presentation/domain_side/componets/basic_item_card.dart';
import 'package:project_5240_frontend/presentation/widgets/Customize_text/basic_item.dart';
import 'package:project_5240_frontend/presentation/widgets/textfield.dart';
import 'package:project_5240_frontend/utils/extension.dart';
import '../../widgets/custom_btn.dart';

class AddSubdomin extends StatefulWidget {
  const AddSubdomin({super.key});

  @override
  State<AddSubdomin> createState() => _AddSubdominState();
}

class _AddSubdominState extends State<AddSubdomin> {
  final BasicItemsController basicItemsController =
      Get.put(BasicItemsController());

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final controller = Get.put(AddSubDomainController());
    return Scaffold(
        appBar: AppBar(
          // leading: SvgPicture.asset(Assets.roundedbackIc),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add New Items',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Color(0xff181C2E)),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    controller.pickedImagesList.clear();
                    controller.titleController.clear();
                    controller.descriptionController.clear();
                    basicItemsController.basicItemOne.clear();
                    basicItemsController.basicItemTwo.clear();
                  });
                },
                child: const Text(
                  'RESET',
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Color(0xff32B768),
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color(0xff32B768)),
                ),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                    const Text(
                      'ADD SUBDOMAIN',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xff32343E)),
                    ),
                    SizedBox(
                      height: screenheight * 0.008,
                    ),
                    CustomizeTextField(
                      hinttext: 'Search Item name',
                      controller: controller.titleController,
                    ),
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                    const Text(
                      'UPLOAD PHOTO/VIDEO',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xff32343E)),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => GridView.builder(
                        itemCount: controller.pickedImagesList.length +
                            1, // +1 for the add button
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5, // Number of items per row
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 80,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          // Check if it's the last index (reserved for the Add button)
                          if (index == controller.pickedImagesList.length) {
                            return Padding(
                              padding:
                                  EdgeInsets.only(left: index % 5 == 4 ? 0 : 4),
                              child: GestureDetector(
                                onTap: () async {
                                  // Image picker logic here
                                  controller.pickImageFromGallery();
                                },
                                child: Container(
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
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.lighGrey,
                                  image: DecorationImage(
                                    image: FileImage(
                                        controller.pickedImagesList[index]),
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
                                        color: AppColors.starRedColor
                                            .withOpacity(0.2),
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.close_outlined,
                                      size: 16,
                                      color: AppColors.starRedColor,
                                    ),
                                  ),
                                ),
                                onTap: () =>
                                    controller.removeImageWithIndex(index),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'LOREM',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color(0xff32343E)),
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.012,
                    ),
                    const BasicItemText(text: 'Basic Item 1', listType: 1),
                    const SizedBox(height: 10),
                    GetBuilder<BasicItemsController>(builder: (bController) {
                      controller.update();
                      int itemCount =
                          (bController.basicitem?.basicItems?.length ?? 0) > 5
                              ? 5
                              : bController.basicitem?.basicItems?.length ?? 0;
                      return Row(
                        children: List.generate(
                          itemCount,
                          (index) => BasicItemCard(
                            index,
                            basicItems: bController.basicitem?.basicItems,
                            isActive: bController.basicItemOne.contains(
                                bController.basicitem?.basicItems?[index].sId),
                            onTap: () {
                              bController.toggleSelection(
                                  bController
                                          .basicitem?.basicItems?[index].sId ??
                                      "",
                                  1);

                              debugPrint(
                                  "basicItemOne==>${bController.basicItemOne}");
                              bController.update();
                            },
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: screenheight * 0.011,
                    ),
                    const BasicItemText(text: 'Basic Item 2', listType: 2),
                    const SizedBox(height: 10),
                    GetBuilder<BasicItemsController>(builder: (bController) {
                      int itemCount =
                          (bController.basicitem2?.basicItems?.length ?? 0) > 5
                              ? 5
                              : bController.basicitem2?.basicItems?.length ?? 0;
                      return Row(
                        children: List.generate(
                          itemCount,
                          (index) => BasicItemCard(
                            index,
                            basicItems: bController.basicitem2?.basicItems,
                            isActive: bController.basicItemTwo.contains(
                                    bController
                                        .basicitem2?.basicItems?[index].sId)
                                ? true
                                : false,
                            onTap: () {
                              bController.toggleSelection(
                                  bController
                                          .basicitem2?.basicItems?[index].sId ??
                                      "",
                                  2);
                              debugPrint(
                                  "basicItemTwo==>${bController.basicItemTwo}");
                              bController.update();
                            },
                          ),
                        ),
                      );
                    }),
                    SizedBox(
                      height: screenheight * 0.013,
                    ),
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff32343E)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      maxLines: 4,
                      controller: controller.descriptionController,
                      decoration: InputDecoration(
                        // The main border with AppColors.lightGrey when not focused
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color:
                                AppColors.lighGrey, // Use AppColors for border
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),

                        // The border color when focused
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: AppColors
                                .lighGrey, // Change this to your desired focus color
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),

                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        hintText: "description",
                        hintStyle: const TextStyle(
                          fontFamily: "inter",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: screenheight * 0.024,
                    ),
                    Center(
                      child: Obx(() => controller.isLoading.value
                          ? const NutsActivityIndicator(
                              activeColor: Colors.white,
                              inactiveColor: AppColors.green,
                              tickCount: 24,
                              relativeWidth: 0.4,
                              radius: 20,
                              startRatio: 0.7,
                              animationDuration: Duration(milliseconds: 500),
                            )
                          : CustomizeButton(
                              color: const Color.fromRGBO(50, 183, 104, 1),
                              textColor: Colors.white,
                              width: screenWidth * 0.7,
                              text: 'Add',
                              height: screenheight * 0.049,
                              onTap: () =>
                                  (controller.titleController.text.isNotEmpty &&
                                          controller
                                              .pickedImagesList.isNotEmpty &&
                                          controller.descriptionController.text
                                              .isNotEmpty &&
                                          (basicItemsController
                                                  .basicItemOne.isNotEmpty ||
                                              basicItemsController
                                                  .basicItemTwo.isNotEmpty))
                                      ? controller
                                          .addDomainData(
                                              title: controller
                                                  .titleController.text,
                                              status: "Active",
                                              description: controller
                                                  .descriptionController.text,
                                              basicItem1Id: basicItemsController
                                                  .basicItemOne,
                                              basicItem2Id: basicItemsController
                                                  .basicItemTwo)
                                          .then((value) {
                                          if (value!) {
                                            controller.pickedImagesList.clear();
                                            controller.titleController.clear();
                                            controller.descriptionController
                                                .clear();
                                            basicItemsController.basicItemOne
                                                .clear();
                                            basicItemsController.basicItemTwo
                                                .clear();
                                            basicItemsController.update();
                                          }
                                        })
                                      : Fluttertoast.showToast(
                                          msg: "All fields are required",
                                          backgroundColor:
                                              AppColors.starRedColor,
                                          textColor: Colors.white,
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                        ),
                            )),
                    ),
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                  ])),
        ));
  }

  // Widget _basicItemView(int index,
  //     {List<BasicItems>? basicItems,
  //     void Function()? onTap,
  //     bool isActive = false}) {
  //   return GestureDetector(
  //     onTap: onTap,
  //     child: Padding(
  //       padding: const EdgeInsets.only(right: 20),
  //       child: Column(
  //         children: [
  //           CircleAvatar(
  //             backgroundImage:
  //                 CachedNetworkImageProvider(basicItems?[index].icon ?? ""),
  //           ),
  //           Text(
  //             basicItems?[index].name ?? "",
  //             style: TextStyle(
  //               fontFamily: "inter",
  //               fontSize: 14,
  //               color: isActive ? AppColors.green : Colors.black,
  //               fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );

  // }
}
