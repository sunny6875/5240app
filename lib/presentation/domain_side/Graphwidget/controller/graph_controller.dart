import 'package:get/get.dart';

class StockController extends GetxController {
  var isLoading = false.obs;
  var totalViews = 0.obs;
  var errorMessage = RxnString(null);

  @override
  void onInit() {
    fetchStocks();
    super.onInit();
  }

  void fetchStocks() async {
    try {
      isLoading.value = true;
      // Simulate an API call
      await Future.delayed(const Duration(seconds: 2));
      totalViews.value = 10; // Example value
    } catch (error) {
      errorMessage.value = "Error fetching stocks";
    } finally {
      isLoading.value = false;
    }
  }
}
