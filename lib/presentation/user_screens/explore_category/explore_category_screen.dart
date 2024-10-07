// ignore_for_file: unused_local_variable, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:project_5240_frontend/presentation/user_screens/home/explore_domain/explore_domain_screen.dart';
import 'package:project_5240_frontend/utils/extension.dart';

import '../accounts/account_screen.dart';
import '../accounts/controller/account_controller.dart';

class ExploreCategoryScreen extends StatefulWidget {
  const ExploreCategoryScreen({super.key});

  @override
  State<ExploreCategoryScreen> createState() => _ExploreCategoryScreenState();
}

class _ExploreCategoryScreenState extends State<ExploreCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    final CategoryController categoryController =
        Get.put(CategoryController()); // Inject controller
    final AccountController accountController = Get.find<AccountController>();
    final DomainController _domainController = Get.put(DomainController());

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: IconButton(
          // This adds the back arrow manually
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back(); // Go back to the previous screen
          },
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(AccountScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider(
                    accountController.profileModel?.user?.userProfile ?? ""),
              ),
            ),
          )
        ],
        backgroundColor: const Color(0xffFFFFFF),
        title: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_pin),
              Flexible(
                child: Text(
                  _domainController.currentLocation?.value ?? "",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff4B5563),
                  ),
                ),
              ),
            ],
          );
        }),
        centerTitle: true,
      ),
      body: Obx(() {
        if (_domainController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        ' Explore Category', // Access to subdomain title
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Categories",
                          style: GoogleFonts.fredoka(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff4B5563),
                          ),
                        ),
                        Text(
                          "",
                          style: GoogleFonts.fredoka(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff32B768),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        "Lorem ipsum dolor sit amet",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff6B7280),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(child: CategoriesView())
            ],
          ),
        );
      }),
    );
  }
}

class CategoriesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the controller
    final CategoryController categoryController = Get.find();
    final ExploreDomainController domainController = Get.put(ExploreDomainController()); // Declare without initializing

    return Obx(() {
      if (categoryController.isLoading.value) {
        // Show loading indicator while data is loading
        return const Center(child: CircularProgressIndicator());
      }

      // Display categories in a grid view
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
          childAspectRatio: 1.0,
        ),
        itemCount: categoryController.categories.length,
        itemBuilder: (context, index) {
          var category =
              categoryController.categories[index]; // Get the category
          return GestureDetector(
            onTap: () {
              domainController.fetchDomainDetails(category['_id']);

              // Navigate to ExploreDomainScreen and pass the selected category ID
              Get.to(() => ExploreDomainScreen(categoryIds: category['_id']));
            },
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
                          errorListener: (p0) => const Icon(Icons.image),
                          category['image'] ?? category['categoryIcon'],
                        )),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black12, width: 1),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  category['title'] ??
                      category['categoryName'], // Access title from the map
                  overflow: TextOverflow.ellipsis,
                ), // Display category title
              ],
            ),
          );
        },
      );
    });
  }
}
