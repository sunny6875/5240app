import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/presentation/constants/assets.dart';
import 'package:project_5240_frontend/presentation/domain_side/componets/custom_textview.dart';
import '../user_screens/accounts/account_screen.dart';
import '../user_screens/accounts/controller/account_controller.dart';
import 'controller/subdomin_controller.dart';

class DomainSearchWidget extends StatelessWidget {
  DomainSearchWidget({super.key});

  final AccountController accountController = Get.put(AccountController());
  final subdominController = Get.put(SubdominController());

  @override
  Widget build(BuildContext context) {
    subdominController.fetchSubDomains();
    return GetBuilder<SubdominController>(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: SvgPicture.asset(
              Assets.drawer,
              width: 20.0,
              height: 20.0,
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Get.to(AccountScreen());
                },
                child: accountController.profileModel?.user?.userProfile != null
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: CachedNetworkImageProvider(
                              accountController
                                      .profileModel?.user?.userProfile ??
                                  ""),
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          radius: 25,
                          child: Icon(Icons.person),
                        ),
                      ),
              )
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  Assets.locationicongreen,
                ),
                const SizedBox(
                  width: 5,
                ),
                Obx(
                  () => SizedBox(
                    width: 120,
                    child: CustomTextView(
                      accountController.currentLocation?.value ??
                          "Your Location",
                      style: const TextStyle(
                          fontSize: 12, fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: GetBuilder<SubdominController>(builder: (controller) {
              return Container(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  children: [
                    searchWidget(
                      onSearch: (value) {
                        subdominController.searchQuery(value);
                        subdominController.update();
                      },
                    ),
                    const SizedBox(height: 25),
                    popularSubDomainWidget(),
                    const SizedBox(height: 25),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }

  Widget searchWidget({required Function(String) onSearch}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        color: AppColors.search_bg,
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.search,
            width: 18.0,
            height: 18.0,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onChanged: onSearch, // Trigger search action on text input
              decoration: const InputDecoration(
                hintText: "Search",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xff9CA3AF),
                  fontWeight: FontWeight.w400,
                ),
              ),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget popularSubDomainWidget() {
    return GetBuilder<SubdominController>(builder: (subdominController) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const CustomTextView(
                "Your Popular Subdomain",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              CustomTextView(
                "See All",
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.grayblack,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 3),
              SvgPicture.asset(
                Assets.rightarrow,
                width: 10,
                height: 10,
              ),
            ],
          ),
          const SizedBox(height: 10),
          subdominController.filteredSubdomains.isNotEmpty
              ? buildSubdomainGrid(subdominController.filteredSubdomains)
              : const SizedBox(
                  height: 500,
                  child: Center(child: Text('No subdomains available')),
                ),
          const SizedBox(height: 20),
        ],
      );
    });
  }

  Widget buildSubdomainGrid(List<dynamic> subdomains) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        mainAxisExtent: 200,
      ),
      itemCount: subdomains.length,
      itemBuilder: (context, index) {
        return buildSubdomainCard(subdomains[index]);
      },
    );
  }

  Widget buildSubdomainCard(dynamic subdomain) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 2,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSubdomainImageCarousel(subdomain),
            const SizedBox(height: 16),
            CustomTextView(
              subdomain["title"] ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSubdomainImageCarousel(dynamic subdomain) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.search_bg,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(15.0),
          topLeft: Radius.circular(15.0),
        ),
      ),
      height: 100,
      child: CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1.0,
          height: 100.0,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        items: (subdomain["image"] as List<dynamic>)
            .map<Widget>(
              (item) => CachedNetworkImage(
                imageUrl: item as String,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error, size: 50.0)),
              ),
            )
            .toList(),
      ),
    );
  }
}