
import 'package:project_5240_frontend/utils/extension.dart';



class CategoryController extends GetxController {
  var categories = [].obs; // Observable list to store categories
  var isLoading = true.obs; // Observable loading state

  @override
  void onInit() {
    fetchCategories(); // Fetch categories when controller is initialized
    super.onInit();
  }

  // Function to fetch categories from the API
  void fetchCategories() async {
    try {

      isLoading(true); // Start loading
     final response =await BaseClient.get(api:  EndPoints.allCategories);

      if  ( response!=null && response.statusCode == 200) {
        var responseData = response.data;
        categories.value = responseData['category_list'];// Assign API data to the observable list
      }
    } catch (e) {
      print("Error fetching categories: $e");
    } finally {
      isLoading(false); // Stop loading
    }
  }
}
