// ignore_for_file: unnecessary_null_comparison, unused_local_variable, unused_field

import 'package:cached_network_image/cached_network_image.dart';
import 'package:project_5240_frontend/presentation/user_screens/details/details.dart';
import 'package:project_5240_frontend/presentation/user_screens/explore_category/explore_category_screen.dart';

import '../../../utils/extension.dart';
import '../accounts/account_screen.dart';
import '../accounts/controller/account_controller.dart';
import '../notification/notification_screen.dart';
import 'explore_domain/explore_domain_screen.dart';
import 'filtter/home_filter.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final ScrollController _scrollController = ScrollController();
  String _appBarText = "";
  bool _showAppBarText = true;
  final DomainController _domainController = Get.put(DomainController());
  final AccountController accountController = Get.find<AccountController>();
  final ExploreDomainController domainController =
      Get.put(ExploreDomainController()); // Declare without initializing

  @override
  void initState() {
    super.initState();

    _domainController
        .fetchDomains(); // Fetch domains when the screen is initialized

    _scrollController.addListener(() {
      if (_scrollController.offset < 30) {
        if (!_showAppBarText) {
          setState(() {
            _showAppBarText = true;
            _appBarText = "";
          });
        }
      } else {
        if (_showAppBarText) {
          setState(() {
            _showAppBarText = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void showLocationBottomSheet(BuildContext context) {
    final TextEditingController locationController = TextEditingController();

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      barrierColor: Colors.black.withOpacity(0.8),
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: 30,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Fetching your location",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Lorem ipsum dolor sit amet consectetur. Pharetra volutpat imperdiet facilisis ac sit.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    hintText: "Enter your location",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (locationController.text.isNotEmpty) {
                        _domainController
                            .updateLocationManually(locationController.text);
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize:
                          const Size(double.infinity, 50), // Full-width button
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontSize: 16,color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<DomainController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(AccountScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: CachedNetworkImageProvider(
                            accountController.profileModel?.user?.userProfile ??
                                ""),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      Get.to(NotificationScreen());
                    },
                    child: SvgPicture.asset(
                      "assets/icons/notification.svg",
                      width: 24,
                      height: 24,
                    ),
                  )
                ],
              ),
            ),
          ],
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'App Name',
                style: TextStyle(
                    color: Color(0xFF4B5563),
                    fontSize: 24,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/icons/location.svg",
                                  width: 24, height: 24),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Location",
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 8,
                                          child: Obx(
                                            () => Text(
                                              controller.currentLocation!.value,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        PopupMenuButton<String>(
                                          padding: EdgeInsets.zero,
                                          color: Colors.white,
                                          icon: const Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: Colors.orange,
                                          ),
                                          itemBuilder: (BuildContext context) {
                                            return [
                                              const PopupMenuItem(
                                                value: 'Your location',
                                                child: Text('Your location'),
                                              ),
                                              const PopupMenuItem(
                                                value: 'Manual Location',
                                                child: Text('Enter manually'),
                                              ),
                                            ];
                                          },
                                          onSelected: (value) {
                                            if (value == 'Manual Location') {
                                              // _showLocationBottomSheet(context);
                                              showLocationBottomSheet(context);
                                            } else {
                                              controller
                                                  .getCurrentLocationDetails(); // Use current location
                                            }
                                          },
                                        ),
                                        const Spacer(flex: 2),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                context: context,
                                barrierColor: Colors.black.withOpacity(0.8),
                                backgroundColor: Colors.white,
                                elevation: 0,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(30),
                                      topLeft: Radius.circular(30)),
                                ),
                                builder: (BuildContext context) {
                                  return const HomeFilterBottomSheet();
                                },
                              );
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.3),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(14)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: Image.asset(
                                      "assets/images/filter.png",
                                      height: 24,
                                      width: 24,
                                    ),
                                  ),
                                  const Text(
                                    "Filter",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "inter"),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(13),
                child: TextField(
                  onTap: () {
                    domainController.mostviewfetchDomains();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ExploreDomainScreen(),
                      ),
                    );
                  },
                  readOnly: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFFE6E7E9),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none),
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Categories",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const ExploreCategoryScreen());
                      },
                      child: const Text(
                        "View All",
                        style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF32B768),
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
              CategoriestWidgetsHome(),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Explore Name Domain",
                      style: TextStyle(
                        fontFamily: "inter",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      "Check your city Near by Name domain",
                      style: TextStyle(
                        fontFamily: "inter",
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (_domainController.isLoading.value) {
                  return const Center(
                      child:
                          CircularProgressIndicator()); // Show loading indicator while fetching
                }

                var domains = _domainController.domainList;

                // Check if domains is null or empty
                if (domains == null || domains.isEmpty) {
                  return const Center(
                      child:
                          Text("No domains available")); // Handle no data case
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      domains.length, // Use the length of the domain list
                  itemBuilder: (context, index) {
                    var domain = domains[index];

                    // Check if the domain is a Map
                    if (domain is Map<String, dynamic>) {
                      // String imageUrl = domain['image'] ?? 'https://via.placeholder.com/283x156'; // Provide a placeholder image if no image is available
                      List<String> imageUrls =
                          List<String>.from(domain['image'] ?? []);

                      if (imageUrls.isEmpty) {
                        // Use a placeholder if no images are available
                        imageUrls = ['https://via.placeholder.com/283x156'];
                      }
                      // Display the title, location, and image
                      return GestureDetector(
                        onTap: () {
                          // Navigate to the details screen and pass the selected domain
                          Get.to(() => DetailsScreen(domain: domain));
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Colors.red),
                          // ),
                          child: Card(
                            color: AppColors.white,
                            child: Column(
                              children: [
                                // Display images in a horizontally scrollable list
                                Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  height: 156,
                                  width: double.infinity,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: imageUrls.length,
                                    itemBuilder: (context, imageIndex) {
                                      return Container(
                                        width: 283,
                                        height: 156,
                                        margin: const EdgeInsets.only(
                                            right: 10, left: 16),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.lighGrey,
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: CachedNetworkImageProvider(
                                              imageUrls[imageIndex],
                                              errorListener: (p0) => const Icon(
                                                  Icons.error,
                                                  color: Colors.red),
                                            ),
                                          ),
                                        ),
                                        // child: ClipRRect(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   child: Image.network(
                                        //     "imageUrls[imageIndex]",
                                        //     fit: BoxFit.cover,
                                        //     errorBuilder:
                                        //         (context, error, stackTrace) {
                                        //       return const Center(
                                        //           child: Icon(Icons.error,
                                        //               color: Colors.red));
                                        //     },
                                        //     loadingBuilder: (context, child,
                                        //         loadingProgress) {
                                        //       if (loadingProgress == null) {
                                        //         return child;
                                        //       }
                                        //       return const Center(
                                        //           child:
                                        //               CircularProgressIndicator());
                                        //     },
                                        //   ),
                                        // ),
                                      );
                                    },
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14, vertical: 16),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 9),
                                            child: Text(
                                              domain['title'] ?? '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on_rounded,
                                                color: Colors.green,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              SizedBox(
                                                width: 160,
                                                child: Text(
                                                  domain['location'] is String
                                                      ? domain[
                                                          'location'] // If it's a String, show it directly
                                                      : domain['location']
                                                              ['name'] ??
                                                          '',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(() => DetailsScreen(
                                              domain:
                                                  domain)); // Navigate to details
                                        },
                                        child: Container(
                                          height: 28,
                                          width: 88,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.green,
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "View",
                                              style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      // Handle unexpected data format
                      return const Text("Invalid data format");
                    }
                  },
                );
              }),
            ],
          ),
        ),
      );
    });
  }

  // Widget buildCustomBottomSheet() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 30),
  //     child: Container(
  //       height: 350,
  //       color: Colors.white,
  //       child: SingleChildScrollView(
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: <Widget>[
  //             const IntrinsicHeight(
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Text("Location"),
  //                   TextField(),
  //                   SizedBox(height: 10),
  //                   Text("Other Filter"),
  //                   TextField(),
  //                 ],
  //               ),
  //             ),
  //             SizedBox(height: 20),
  //             Center(
  //               child: ElevatedButton(
  //                 onPressed: () {},
  //                 child: Text("Apply"),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
