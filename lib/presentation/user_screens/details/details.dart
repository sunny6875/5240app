// ignore_for_file: library_private_types_in_public_api

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/presentation/user_screens/accounts/controller/account_controller.dart';
import 'package:project_5240_frontend/presentation/user_screens/details/approval.dart';
import 'package:project_5240_frontend/presentation/user_screens/details/controller/details_controller.dart';
import 'package:project_5240_frontend/presentation/user_screens/details/information.dart';
import 'package:project_5240_frontend/presentation/user_screens/details/options.dart';

import '../../constants/assets.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key, required this.domain});
  final Map<String, dynamic> domain;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final PageController _pageController = PageController();
  final DetailsController detailsController = Get.put(DetailsController());
  final acountController = Get.find<AccountController>();
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    acountController.getProfileData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // Get the list of images from the domain data
    List<String> imageUrls = List<String>.from(widget.domain['image'] ?? []);

    if (imageUrls.isEmpty) {
      // Use a placeholder if no images are available
      imageUrls = ['https://via.placeholder.com/283x156'];
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            size: 24,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Details',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xff1F2937)),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.015),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${widget.domain['title']}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Color(0xff1F2937)),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          color: Color(0xff32B768),
                        ),
                        Text(
                          widget.domain['location'] is String
                              ? widget.domain['location']
                              : widget.domain['location']['name'] ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Color(0xff6B7280)),
                        ),
                      ],
                    ),
                  ],
                ),
                GetBuilder<DetailsController>(builder: (controller) {
                  bool isSaved = controller.isItemSaved(widget.domain["_id"]);
                  return Container(
                    height: 35,
                    width: 35,
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                        onPressed: () {
                          controller.toggleSave(context, widget.domain["_id"]);
                        },
                        icon: Icon(
                          isSaved ? Icons.favorite : Icons.favorite_border,
                          color: isSaved ? Colors.red : Colors.grey,
                          size: 20,
                        )),
                  );
                }),
              ],
            ),

            SizedBox(height: screenHeight * 0.024),
            SizedBox(
              width: double.infinity,
              height: screenHeight * 0.2,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: screenHeight * 0.2,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    // Display a list of images horizontally
                    child: imageUrls.isNotEmpty
                        ? CarouselSlider(
                            options: CarouselOptions(
                              onPageChanged: (index, reason) {
                                setState(() {
                                  currentIndex = index;
                                });
                              },
                              height: 250.0, // Set height
                              pageSnapping: true,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction:
                                  0.8, // Adjust viewport fraction (between 0.0 to 1.0 for width)
                            ),
                            items: imageUrls.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.green,
                                      borderRadius: BorderRadius.circular(
                                          10), // Set border radius for rounded corners
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              5), // Add slight shadow for effect
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          10), // Clip the image to be rounded
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: i, // Your image URL
                                        placeholder: (context, url) =>
                                            const CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          )
                        : Image.network(
                            'https://via.placeholder.com/150', // Placeholder image
                            fit: BoxFit.cover,
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.2,
                          ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        imageUrls.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: integator(
                              isActive: currentIndex == index ? true : false),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.054),
            // TabBar
            TabBar(
              dividerColor: Colors.transparent,

              indicator: const BoxDecoration(
                color: Colors.transparent,
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xff32B768), // Underline color
                    width: 1.0, // Underline thickness
                  ),
                ),
              ),
              controller: _tabController,
              tabs: [
                Tab(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.asset(Assets.Notebook),
                        const SizedBox(width: 4), // Space between icon and text
                        const Text(
                          'Options',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.asset(Assets.bell),
                        const SizedBox(width: 4), // Space between icon and text
                        const Text(
                          'Information',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(Assets.star),
                        const SizedBox(width: 4), // Space between icon and text
                        const Text(
                          'Approval',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              labelColor: Colors.black, // Color of the selected tab text
            ),
            const SizedBox(height: 8), // Space between TabBar and TabBarView
            // TabBarView
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Options(domain: widget.domain),
                  InformationScreen(domain: widget.domain),
                  const ApprovalScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget integator({isActive = false}) {
    return Container(
      height: 10,
      width: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.green : AppColors.lighGrey,
      ),
    );
  }
}
