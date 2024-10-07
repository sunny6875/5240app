//
//
//
//
// import '../../../../../utils/extension.dart';
//
// class filtterDomainController extends GetxController {
//
//   var domainList = <dynamic>[].obs; // Observable list for domains
//
//   var isLoading = false.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     mostviewfetchDomains();
//     distencefetchDomains();
//   }
//
//   Future<void> mostviewfetchDomains() async {
//     isLoading(true);
//     try {
//       final response = await BaseClient.get(api: "${EndPoints.mostviewDomains}");
//
//       if (response != null && response.statusCode == 200) {
//         domainList.value.clear();
//
//         var jsonResponse = response.data;
//         // domainList = Alldomain.fromJson(response.data);
//
//         debugPrint("-------------------------------------${jsonResponse['domains']}");
//         domainList.value = jsonResponse['domains'] ?? [];
//
//       } else {
//         // Handle error if response is not successful
//         Get.snackbar(
//           'Error',
//           'Failed to load domains',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         print("Error fetching domains");
//       }
//     } catch (e) {
//       print('Error: $e');
//       showDialog(
//         context: Get.context!,
//         builder: (context) {
//           return SimpleDialog(
//             title: Center(child: const Text('Error')),
//             contentPadding: const EdgeInsets.all(20),
//             children: [
//               Text(
//                 e.toString(),
//               ),
//             ],
//           );
//         },
//       );
//     } finally {
//       isLoading(false);
//     }
//   }
//
//   Future<void> distencefetchDomains() async {
//     isLoading(true);
//     try {
//       final response = await BaseClient.get(api: "${EndPoints.distenceDomains}");
//
//       if (response != null && response.statusCode == 200) {
//         domainList.value.clear();
//         var jsonResponse = response.data;
//         // domainList = Alldomain.fromJson(response.data);
//
//         debugPrint("-------------------------------------${jsonResponse['domains']}");
//         domainList.value = jsonResponse['domains'] ?? [];
//
//       } else {
//         // Handle error if response is not successful
//         Get.snackbar(
//           'Error',
//           'Failed to load domains',
//           snackPosition: SnackPosition.BOTTOM,
//           backgroundColor: Colors.red,
//           colorText: Colors.white,
//         );
//         print("Error fetching domains");
//       }
//     } catch (e) {
//       print('Error: $e');
//       showDialog(
//         context: Get.context!,
//         builder: (context) {
//           return SimpleDialog(
//             title: Center(child: const Text('Error')),
//             contentPadding: const EdgeInsets.all(20),
//             children: [
//               Text(
//                 e.toString(),
//               ),
//             ],
//           );
//         },
//       );
//     } finally {
//       isLoading(false);
//     }
//   }
// }