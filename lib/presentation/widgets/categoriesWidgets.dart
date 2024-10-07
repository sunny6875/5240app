import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/presentation/user_screens/explore_category/controller/category_controller.dart';
import '../user_screens/home/explore_domain/controller/explore_domin_controller.dart';
import '../user_screens/home/explore_domain/explore_domain_screen.dart'; // Import the DetailsScreen

class CategoriestWidgetsHome extends StatelessWidget {
  final CategoryController categoriesController = Get.put(CategoryController());
  final ExploreDomainController domainController = Get.put(ExploreDomainController()); // Declare without initializing

  CategoriestWidgetsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        if (categoriesController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (categoriesController.categories.isEmpty) {
          return const Center(child: Text("No categories available."));
        } else {
          // Limit the number of categories to 10
          var limitedCategories =
              categoriesController.categories.take(8).toList();

          return SizedBox(
            height: MediaQuery.of(context).size.height *
                0.25, // Adjust height to fit the content
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // Number of columns
                crossAxisSpacing: 0.0,
                mainAxisSpacing: 0.0, // Adjust spacing between items
                childAspectRatio: 1.0, // Aspect ratio of each grid item
              ),
              itemCount: limitedCategories.length,
              itemBuilder: (context, index) {
                var category = limitedCategories[index]; // Get the category
                return GestureDetector(
                  onTap: () {
                    // Navigate to DetailsScreen when a category is tapped

                    domainController.fetchDomainDetails(category['_id']);
                    Get.to(
                        () => ExploreDomainScreen(categoryIds: category['_id']));

                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          image: DecorationImage( fit: BoxFit.cover,image: CachedNetworkImageProvider(errorListener: (p0) => const Icon(Icons.image), category['image'] ??
                              category[
                              'categoryIcon'], )),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12, width: 1),
                        ),
                      ),
                      const SizedBox(
                          height: 5), // Reduced space below the image
                      Text(
                        category['title'] ??
                            category[
                                'categoryName'], // Access title from the map
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis, // Handle long text
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(fontSize: 12), // Adjust text style
                      ),
                    ],
                  ),
                );
              },
              shrinkWrap: true, // Adjust height based on content
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling
            ),
          );
        }
      }),
    );
  }
}
