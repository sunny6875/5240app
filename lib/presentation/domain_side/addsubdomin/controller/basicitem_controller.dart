import '../../../../../utils/extension.dart';
import '../../../../data/models/provider_side_model/basic_item_model.dart';

class BasicItemsController extends GetxController {
  var isLoading = true.obs;
  BasicItem? basicitem;
  BasicItem? basicitem2;

  var selectedBasicItem = Rxn<BasicItem>();

  @override
  void onInit() {
    fetchbasicitem1();
    fetchbasicitem2();
    super.onInit();
  }

// Two lists to store selected IDs
  var basicItemOne = <String>[].obs; // First list
  var basicItemTwo = <String>[].obs; // Second list

  // Function to handle item tap and toggle between the two lists
  void toggleSelection(String id, int listType) {
    if (listType == 1) {
      // For basicItemOne list
      if (basicItemOne.contains(id)) {
        basicItemOne.remove(id); // Remove if already present
      } else {
        basicItemOne.add(id); // Add if not present
      }
    } else if (listType == 2) {
      // For basicItemTwo list
      if (basicItemTwo.contains(id)) {
        basicItemTwo.remove(id); // Remove if already present
      } else {
        basicItemTwo.add(id); // Add if not present
      }
    }
    update();
  }

  void clearSelections(int? listType) {
    if (listType == 1) {
      basicItemOne.clear();
    } else if (listType == 2) {
      basicItemTwo.clear();
    }
    update();
  }

  Future<void> fetchbasicitem1() async {
    try {
      isLoading(true);
      final response = await BaseClient.get(api: EndPoints.basicitem1);
      if (response != null && response.statusCode == 200) {
        basicitem = BasicItem.fromJson(response.data);
        debugPrint("Basic Item Data =======$basicitem");
        update();
      }
    } catch (e) {
      debugPrint("error =======$e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchbasicitem2() async {
    try {
      isLoading(true);
      final response = await BaseClient.get(api: EndPoints.basicitem2);
      if (response != null && response.statusCode == 200) {
        basicitem2 = BasicItem.fromJson(response.data);
        debugPrint("Basic Item Data =======$basicitem");
        update();
      }
    } catch (e) {
      debugPrint("error =======$e");
    } finally {
      isLoading(false);
    }
  }
}

// Phace 2------------------------

// class BasicItemsController extends GetxController {
//   var isLoading = true.obs;
//   BasicItem? basicitem;
//   BasicItem? basicitem2;

//   // Search-related variables
//   var searchQuery = ''.obs;
//   var filteredBasicItems = <BasicItems>[].obs; // List for filtered items

//   @override
//   void onInit() {
//     fetchbasicitem1();
//     fetchbasicitem2();
//     super.onInit();
//   }

//   // Two lists to store selected IDs
//   var basicItemOne = <String>[].obs; // First list
//   var basicItemTwo = <String>[].obs; // Second list

//   // Function to handle item tap and toggle between the two lists
//   void toggleSelection(String id, int listType) {
//     if (listType == 1) {
//       // For basicItemOne list
//       if (basicItemOne.contains(id)) {
//         basicItemOne.remove(id); // Remove if already present
//       } else {
//         basicItemOne.add(id); // Add if not present
//       }
//     } else if (listType == 2) {
//       // For basicItemTwo list
//       if (basicItemTwo.contains(id)) {
//         basicItemTwo.remove(id); // Remove if already present
//       } else {
//         basicItemTwo.add(id); // Add if not present
//       }
//     }
//     update();
//   }

//   // Search function to filter basic items based on query
//   void searchBasicItems(String query, int listType) {
//     searchQuery.value = query;

//     // Determine which BasicItem list to search based on listType
//     List<BasicItems> selectedBasicItemList = listType == 1
//         ? (basicitem?.basicItems ?? [])
//         : (basicitem2?.basicItems ?? []);

//     if (query.isEmpty) {
//       filteredBasicItems.value =
//           selectedBasicItemList; // Show all items if query is empty
//       update();
//     } else {
//       filteredBasicItems.value = selectedBasicItemList
//           .where(
//               (item) => item.name!.toLowerCase().contains(query.toLowerCase()))
//           .toList();
//       update();
//     }

//     update();
//   }

//   // Function to clear selected items


//   Future<void> fetchbasicitem1() async {
//     try {
//       isLoading(true);
//       final response = await BaseClient.get(api: EndPoints.basicitem1);
//       if (response != null && response.statusCode == 200) {
//         basicitem = BasicItem.fromJson(response.data);
//         filteredBasicItems.value =
//             basicitem?.basicItems ?? []; // Initialize with all items
//         update();
//       }
//     } catch (e) {
//       debugPrint("error =======$e");
//     } finally {
//       isLoading(false);
//     }
//   }

//   Future<void> fetchbasicitem2() async {
//     try {
//       isLoading(true);
//       final response = await BaseClient.get(api: EndPoints.basicitem2);
//       if (response != null && response.statusCode == 200) {
//         basicitem2 = BasicItem.fromJson(response.data);
//         filteredBasicItems.value =
//             basicitem2?.basicItems ?? []; // Initialize with all items
//         update();
//       }
//     } catch (e) {
//       debugPrint("error =======$e");
//     } finally {
//       isLoading(false);
//     }
//   }
// }
// // Phace 3------------------------

// // class BasicItemsController extends GetxController {
// //   var isLoading = true.obs;
// //   BasicItem? basicItemOneList;
// //   BasicItem? basicItemTwoList;

// //   // Search-related variables
// //   var searchQuery = ''.obs;
// //   var filteredBasicItems = <BasicItems>[].obs; // List for filtered items

// //   @override
// //   void onInit() {
// //     fetchBasicItemOne();
// //     fetchBasicItemTwo();
// //     super.onInit();
// //   }

// //   // Lists to store selected IDs
// //   var basicItemOne = <String>[].obs; // First list (for listType 1)
// //   var basicItemTwo = <String>[].obs; // Second list (for listType 2)

// //   // Function to handle item selection toggle
// //   void toggleSelection(String id, int listType) {
// //     if (listType == 1) {
// //       if (basicItemOne.contains(id)) {
// //         basicItemOne.remove(id); // Remove if already selected
// //       } else {
// //         basicItemOne.add(id); // Add if not selected
// //       }
// //     } else {
// //       if (basicItemTwo.contains(id)) {
// //         basicItemTwo.remove(id); // Remove if already selected
// //       } else {
// //         basicItemTwo.add(id); // Add if not selected
// //       }
// //     }
// //     update();
// //   }

// //   // Function to clear selected items
// //   void clearSelections(int? listType) {
// //     if (listType == 1) {
// //       basicItemOne.clear();
// //     } else if (listType == 2) {
// //       basicItemTwo.clear();
// //     }
// //     update();
// //   }

// //   // Search function to filter basic items based on query
// //   void searchBasicItems(String query, int listType) {
// //     searchQuery.value = query;

// //     List<BasicItems> selectedList = listType == 1
// //         ? (basicItemOneList?.basicItems ?? [])
// //         : (basicItemTwoList?.basicItems ?? []);

// //     if (query.isEmpty) {
// //       filteredBasicItems.value = selectedList;
// //     } else {
// //       filteredBasicItems.value = selectedList
// //           .where(
// //               (item) => item.name!.toLowerCase().contains(query.toLowerCase()))
// //           .toList();
// //     }
// //     update();
// //   }

// //   Future<void> fetchBasicItemOne() async {
// //     try {
// //       isLoading(true);
// //       final response = await BaseClient.get(api: EndPoints.basicitem1);
// //       if (response != null && response.statusCode == 200) {
// //         basicItemOneList = BasicItem.fromJson(response.data);
// //         filteredBasicItems.value = basicItemOneList?.basicItems ?? [];
// //         update();
// //       }
// //     } catch (e) {
// //       debugPrint("Error fetching Basic Item One: $e");
// //     } finally {
// //       isLoading(false);
// //     }
// //   }

// //   Future<void> fetchBasicItemTwo() async {
// //     try {
// //       isLoading(true);
// //       final response = await BaseClient.get(api: EndPoints.basicitem2);
// //       if (response != null && response.statusCode == 200) {
// //         basicItemTwoList = BasicItem.fromJson(response.data);
// //         filteredBasicItems.value = basicItemTwoList?.basicItems ?? [];
// //         update();
// //       }
// //     } catch (e) {
// //       debugPrint("Error fetching Basic Item Two: $e");
// //     } finally {
// //       isLoading(false);
// //     }
// //   }
// // }
