// ignore_for_file: unused_local_variable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:project_5240_frontend/presentation/domain_side/componets/basic_item_card.dart';
import 'package:project_5240_frontend/presentation/widgets/textfield.dart';
import '../../../utils/extension.dart';

import 'controller/basicitem_controller.dart';
import '../../../../data/models/provider_side_model/basic_item_model.dart';

class BasicItemsView extends StatefulWidget {
  final int? listType;
  const BasicItemsView({super.key, this.listType});

  @override
  State<BasicItemsView> createState() => _BasicItemsState();
}

class _BasicItemsState extends State<BasicItemsView> {
  BasicItemsController basicitemController = Get.put(BasicItemsController());

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    TextEditingController searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back),
          onTap: () {
            Get.back();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Basic Lorem',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Color(0xff181C2E),
              ),
            ),
            TextButton(
              onPressed: () {
                basicitemController.clearSelections(widget.listType);
              },
              child: const Text(
                'RESET',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xff32B768),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xff32B768),
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.016),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'ITEM NAME',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xff32343E),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.008),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomizeTextField(
                hinttext: 'Search Item name',
                controller: searchController,
              ),
            ),
            SizedBox(height: screenHeight * 0.016),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'LOREM',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xff32343E),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.019),
            GetBuilder<BasicItemsController>(builder: (basicItemController) {
              return Expanded(
                child: Obx(() {
                  debugPrint("ListType===========>${widget.listType}");

                  // Determine which BasicItem list to use based on listType
                  basicItemController.selectedBasicItem.value =
                      widget.listType == 1
                          ? basicitemController.basicitem
                          : basicitemController.basicitem2;

                  // Check for loading state
                  if (basicitemController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  // Check if the selected BasicItem list is empty or null
                  else if (basicItemController
                              .selectedBasicItem.value?.basicItems ==
                          null ||
                      basicItemController
                          .selectedBasicItem.value!.basicItems!.isEmpty) {
                    return const Center(child: Text('No items available'));
                  }
                  // If the data is available, show the GridView
                  else {
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            4, // Change the number of columns as needed
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 0.0,
                        childAspectRatio:
                            1, // Adjust the aspect ratio for the item
                      ),
                      itemCount: basicItemController
                          .selectedBasicItem.value?.basicItems?.length,
                      itemBuilder: (context, index) {
                        // Determine if the current item is active based on listType
                        bool isActive = widget.listType == 1
                            ? basicItemController.basicItemOne.contains(
                                basicItemController.selectedBasicItem.value
                                    ?.basicItems?[index].sId)
                            : basicItemController.basicItemTwo.contains(
                                basicItemController.selectedBasicItem.value
                                    ?.basicItems?[index].sId);

                        return BasicItemCard(
                          index,
                          basicItems: basicItemController
                              .selectedBasicItem.value?.basicItems,
                          isActive: isActive,
                          onTap: () {
                            basicItemController.toggleSelection(
                                basicItemController.selectedBasicItem.value
                                        ?.basicItems?[index].sId ??
                                    "",
                                widget.listType == 1 ? 1 : 2);
                            widget.listType == 1
                                ? debugPrint(
                                    "basicItemOne:${basicItemController.basicItemOne}")
                                : debugPrint(
                                    "basicItemTwo:${basicItemController.basicItemTwo}");
                            basicItemController.update();
                          },
                        );
                      },
                    );
                  }
                }),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget buildGridItem(BasicItems? item, void Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            // padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    item?.icon ?? '',
                    errorListener: (p0) => const Icon(Icons.image),
                  )),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.black, width: 1),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            item?.name ?? 'No Name', // Access title from the map
            overflow: TextOverflow.ellipsis,
          ), // Display category title
        ],
      ),
    );
  }
}
// Phace 2------------------------
// class BasicItemsView extends StatefulWidget {
//   final int? listType;
//   const BasicItemsView({super.key, this.listType});

//   @override
//   State<BasicItemsView> createState() => _BasicItemsState();
// }

// class _BasicItemsState extends State<BasicItemsView> {
//   BasicItemsController basicitemController = Get.put(BasicItemsController());
//   TextEditingController searchController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     var screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           child: const Icon(Icons.arrow_back),
//           onTap: () {
//             Get.back();
//           },
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text(
//               'Basic Lorem',
//               style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: 17,
//                 color: Color(0xff181C2E),
//               ),
//             ),
//             TextButton(
//               onPressed: () {
                // basicitemController.basicItemOne.clear();
                // basicitemController.basicItemTwo.clear();
                // basicitemController.update();
//                 basicitemController.clearSelections(widget.listType);
//               },
//               child: const Text(
//                 'RESET',
//                 style: TextStyle(
//                   decoration: TextDecoration.underline,
//                   decorationColor: Color(0xff32B768),
//                   fontWeight: FontWeight.w400,
//                   fontSize: 14,
//                   color: Color(0xff32B768),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: screenHeight * 0.016),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'ITEM NAME',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 13,
//                   color: Color(0xff32343E),
//                 ),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.008),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: CustomizeTextField(
//                 hinttext: 'Search Item name',
//                 controller: searchController,
//                 onChanged: (query) {
//                   // Trigger the search in the controller
//                   basicitemController.searchBasicItems(query, widget.listType!);
//                 },
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.016),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20),
//               child: Text(
//                 'LOREM',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w400,
//                   fontSize: 13,
//                   color: Color(0xff32343E),
//                 ),
//               ),
//             ),
//             SizedBox(height: screenHeight * 0.019),
//             GetBuilder<BasicItemsController>(builder: (basicItemController) {
//               return Expanded(
//                 child: Obx(() {
//                   // Determine which BasicItem list to use based on listType
//                   BasicItem? selectedBasicItem = widget.listType == 1
//                       ? basicitemController.basicitem
//                       : basicitemController.basicitem2;

//                   // Check for loading state
//                   if (basicitemController.isLoading.value) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   // Check if the filtered list is empty
//                   else if (basicitemController.filteredBasicItems.isEmpty) {
//                     return const Center(child: Text('No items available'));
//                   }
//                   // If the data is available, show the GridView
//                   else {
//                     return GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 4, // Adjust the number of columns
//                         crossAxisSpacing: 0.0,
//                         mainAxisSpacing: 0.0,
//                         childAspectRatio: 1, // Adjust the aspect ratio
//                       ),
//                       itemCount: basicitemController.filteredBasicItems.length,
//                       itemBuilder: (context, index) {
//                         var item =
//                             basicitemController.filteredBasicItems[index];

//                         // Determine if the current item is active based on listType

//                         bool isActive = widget.listType == 1
//                             ? basicItemController.basicItemOne
//                                 .contains(item.sId)
//                             : basicItemController.basicItemTwo
//                                 .contains(item.sId);

//                         return BasicItemCard(
//                           index,
//                           basicItems: selectedBasicItem?.basicItems,
//                           isActive: isActive,
//                           onTap: () {
//                             basicItemController.toggleSelection(
//                                 item.sId ?? "", widget.listType == 1 ? 2 : 1);
//                             basicItemController.update();
//                           },
//                         );
//                       },
//                     );
//                   }
//                 }),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // Phace 3------------------------
// // class BasicItemsView extends StatefulWidget {
// //   final int? listType;
// //   const BasicItemsView({super.key, this.listType});

// //   @override
// //   State<BasicItemsView> createState() => _BasicItemsViewState();
// // }

// // class _BasicItemsViewState extends State<BasicItemsView> {
// //   BasicItemsController basicItemController = Get.put(BasicItemsController());
// //   TextEditingController searchController = TextEditingController();

// //   @override
// //   Widget build(BuildContext context) {
// //     var screenHeight = MediaQuery.of(context).size.height;

// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: GestureDetector(
// //           child: const Icon(Icons.arrow_back),
// //           onTap: () {
// //             Get.back();
// //           },
// //         ),
// //         title: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             const Text(
// //               'Basic Lorem',
// //               style: TextStyle(
// //                 fontWeight: FontWeight.w400,
// //                 fontSize: 17,
// //                 color: Color(0xff181C2E),
// //               ),
// //             ),
// //             TextButton(
// //               onPressed: () {
// //                 // Clear selections
              
// //               },
// //               child: const Text(
// //                 'RESET',
// //                 style: TextStyle(
// //                   decoration: TextDecoration.underline,
// //                   decorationColor: Color(0xff32B768),
// //                   fontWeight: FontWeight.w400,
// //                   fontSize: 14,
// //                   color: Color(0xff32B768),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //         centerTitle: true,
// //       ),
// //       body: Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.start,
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             SizedBox(height: screenHeight * 0.016),
// //             const Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 20),
// //               child: Text(
// //                 'ITEM NAME',
// //                 style: TextStyle(
// //                   fontWeight: FontWeight.w400,
// //                   fontSize: 13,
// //                   color: Color(0xff32343E),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: screenHeight * 0.008),
// //             Padding(
// //               padding: const EdgeInsets.symmetric(horizontal: 20),
// //               child: CustomizeTextField(
// //                 hinttext: 'Search Item name',
// //                 controller: searchController,
// //                 onChanged: (query) {
// //                   basicItemController.searchBasicItems(query, widget.listType!);
// //                 },
// //               ),
// //             ),
// //             SizedBox(height: screenHeight * 0.016),
// //             const Padding(
// //               padding: EdgeInsets.symmetric(horizontal: 20),
// //               child: Text(
// //                 'LOREM',
// //                 style: TextStyle(
// //                   fontWeight: FontWeight.w400,
// //                   fontSize: 13,
// //                   color: Color(0xff32343E),
// //                 ),
// //               ),
// //             ),
// //             SizedBox(height: screenHeight * 0.019),
// //             GetBuilder<BasicItemsController>(builder: (controller) {
// //               return Expanded(
// //                 child: Obx(() {
// //                   List<BasicItems> selectedList = widget.listType == 1
// //                       ? controller.basicItemOneList
// //                       : controller.basicItemTwoList;

// //                   // Check if loading
// //                   if (controller.isLoading.value) {
// //                     return const Center(child: CircularProgressIndicator());
// //                   }

// //                   // Check if the filtered list is empty
// //                   if (controller.filteredBasicItems.isEmpty) {
// //                     return const Center(child: Text('No items available'));
// //                   }

// //                   // Show the GridView
// //                   return GridView.builder(
// //                     gridDelegate:
// //                         const SliverGridDelegateWithFixedCrossAxisCount(
// //                       crossAxisCount: 4,
// //                       crossAxisSpacing: 0.0,
// //                       mainAxisSpacing: 0.0,
// //                       childAspectRatio: 1,
// //                     ),
// //                     itemCount: controller.filteredBasicItems.length,
// //                     itemBuilder: (context, index) {
// //                       var item = controller.filteredBasicItems[index];

// //                       // Determine if the item is selected
// //                       bool isActive = widget.listType == 1
// //                           ? controller.basicItemOne.contains(item.sId)
// //                           : controller.basicItemTwo.contains(item.sId);

// //                       return BasicItemCard(
// //                         index,
// //                         basicItems: selectedList,
// //                         isActive: isActive,
// //                         onTap: () {
// //                           controller.toggleSelection(
// //                               item.sId ?? "", widget.listType!);
// //                         },
// //                       );
// //                     },
// //                   );
// //                 }),
// //               );
// //             }),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
