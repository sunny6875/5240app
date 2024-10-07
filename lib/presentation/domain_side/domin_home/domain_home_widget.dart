// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:project_5240_frontend/presentation/constants/assets.dart';
import 'package:project_5240_frontend/presentation/domain_side/adddomin/add_domain_widget.dart';
import 'package:project_5240_frontend/presentation/domain_side/domain_search.dart';
import '../../../utils/extension.dart';
import '../../user_screens/accounts/account_screen.dart';
import '../../user_screens/accounts/controller/account_controller.dart';
import '../Graphwidget/graph_view.dart';
import '../componets/custom_textview.dart';
import '../controller/subdomin_controller.dart';
import 'controller/dominhome_controller.dart';

class DomainHomeWidget extends StatefulWidget {
  const DomainHomeWidget({super.key});

  @override
  State<DomainHomeWidget> createState() => _DomainHomeWidgetState();
}

class _DomainHomeWidgetState extends State<DomainHomeWidget> {
  final AccountController accountController = Get.find<AccountController>();
  final DomainidController dominController = Get.put(DomainidController());
  final SubdominController subdominController = Get.put(SubdominController());

  @override
  Widget build(BuildContext context) {
    subdominController.fetchSubDomains();

    return GetBuilder<AccountController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              "assets/images/menu.png",
            ),
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
                            accountController.profileModel?.user?.userProfile ??
                                ""),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
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
                    controller.currentLocation?.value ?? "Your Location",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              )
            ],
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: GetBuilder<DomainidController>(builder: (dominController) {
            return Container(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Obx(() {
                if (dominController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (dominController.domainModel.value?.domain == null ||
                    accountController.profileModel?.user?.isDomainAdded ==
                        false) {
                  return SizedBox(
                    height: 600,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'No domains available',
                            style: TextStyle(
                              fontFamily: "inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () {
                            Get.to(AddDomainWidget(
                              afterLoginAddDomain: true,
                            ))!
                                .then((value) => dominController.fetchDomain());
                          },
                          color: AppColors.green,
                          child: Text(
                            "Add Domain",
                            style: TextStyle(
                              fontFamily: "inter",
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(DomainSearchWidget());
                      },
                      child: searchWidget(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: CustomTextView(
                          dominController.domainModel.value?.domain?.title ??
                              "",
                          style: const TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    totalcountWidget(),
                    const SizedBox(
                      height: 25,
                    ),
                    const GraphView(),
                    const SizedBox(
                      height: 10,
                    ),
                    popularSubDomainWidget(),
                    const SizedBox(height: 30),
                  ],
                );
              }),
            );
          }),
        ),
      );
    });
  }

  appBarWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          Assets.drawer,
          width: 20.0,
          height: 20.0,
        ),
        Row(
          children: [
            SvgPicture.asset(
              Assets.locationicongreen,
              width: 10.0,
              height: 10.0,
            ),
            const SizedBox(
              width: 5,
            ),
            const CustomTextView(
              "Agrabad 435, Chittagong",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const CircleAvatar(
            radius: 25,
            backgroundImage:
                NetworkImage('https://via.placeholder.com/140x100')),
      ],
    );
  }

  Widget searchWidget() {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 15),
      margin: const EdgeInsets.only(left: 15, right: 15),
      decoration: const BoxDecoration(
        color: AppColors.search_bg,
        borderRadius: BorderRadius.all(
            Radius.circular(50) //                 <--- border radius here
            ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            Assets.search,
            width: 18.0,
            height: 18.0,
          ),
          const SizedBox(
            width: 8,
          ),
          const CustomTextView(
            "Search",
            style: TextStyle(
                fontSize: 14,
                color: Color(0xff9CA3AF),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }

  Widget totalcountWidget() {
    final DomainidController dominController = Get.put(DomainidController());

    return Obx(() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextView(
                dominController.domainModel.value?.domain?.viewCount
                        .toString() ??
                    "", // Display the viewCount
                style: TextStyle(
                    fontSize: 52,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              CustomTextView(
                "Total Views",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.lightgrayBlack,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextView(
                dominController.domainModel.value?.domain?.viewCount
                        .toString() ??
                    "0", // This can be dynamic as well, if needed
                style: TextStyle(
                    fontSize: 52,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              CustomTextView(
                "Total Added You",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.lightgrayBlack,
                    fontWeight: FontWeight.w700),
              ),
            ],
          )
        ],
      );
    });
  }

  Widget popularSubDomainWidget() {
    return GetBuilder<SubdominController>(builder: (subdominController) {
      return SizedBox(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return AddDomainWidget();
                      },
                    );
                  },
                  child: const CustomTextView(
                    "Your Popular Subdomain",
                    style: TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    Get.to(DomainSearchWidget());
                  },
                  child: CustomTextView(
                    "See All",
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.grayblack,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  width: 3,
                ),
                SvgPicture.asset(
                  Assets.rightarrow,
                  width: 10,
                  height: 10,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Obx(() {
              if (subdominController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (subdominController.subDomainModel?.subdomains == null) {
                return Center(
                  child: Text('No subdomains available'),
                );
              }
              // Show only 10 items on the screen
              int itemsToShow =
                  subdominController.subDomainModel!.subdomains!.length > 10
                      ? 10
                      : subdominController.subDomainModel!.subdomains!.length;

              return GetBuilder<SubdominController>(
                  builder: (subdominController) {
                return SizedBox(
                  height: 210,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: itemsToShow,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        shadowColor: Colors.white,
                        color: Colors.white,
                        elevation: 2,
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 8, right: 8, bottom: 10, top: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: AppColors.search_bg,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15.0),
                                    topLeft: Radius.circular(15.0),
                                  ),
                                ),
                                height: 100,
                                width: 140,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      viewportFraction: 1.0,
                                      height: 110.0, // Slider height
                                      autoPlay: true, // Enable auto-slide
                                      enlargeCenterPage:
                                          true, // Enlarges the center item
                                    ),
                                    items: subdominController.subDomainModel
                                        ?.subdomains?[index].image
                                        ?.map(
                                          (item) => SizedBox(
                                            child: CachedNetworkImage(
                                              imageUrl: item,
                                              fit: BoxFit.cover,
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child: NutsActivityIndicator(
                                                  activeColor: Colors.white,
                                                  inactiveColor:
                                                      AppColors.green,
                                                  tickCount: 24,
                                                  relativeWidth: 0.4,
                                                  radius: 20,
                                                  startRatio: 0.7,
                                                  animationDuration: Duration(
                                                      milliseconds: 500),
                                                ), // Loading spinner while image loads
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Center(
                                                child: Icon(Icons.error,
                                                    size: 50.0,
                                                    color: Colors.black.withOpacity(
                                                        0.3)), // Error widget for invalid URLs
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: 140,
                                child: CustomTextView(
                                  subdominController.subDomainModel
                                          ?.subdomains?[index].title ??
                                      "",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              });
            }),
          ],
        ),
      );
    });
  }
}
