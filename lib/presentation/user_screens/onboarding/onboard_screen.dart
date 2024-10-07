import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/presentation/constants/colors.dart';
import 'package:project_5240_frontend/presentation/constants/strings.dart';
import 'package:project_5240_frontend/presentation/user_screens/onboarding/controller.dart/onbording_controller.dart';
import '../../constants/assets.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});

  final PageController _pageController = PageController(initialPage: 0);
  final OnboardingController _controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              _controller.setPage(page);
            },
            children: [
              buildPage(
                screenWidth: MediaQuery.of(context).size.width,
                screenHeight: MediaQuery.of(context).size.height,
                title: AppStrings.mainFeature,
                description: AppStrings.mainFeatureDiscription,
              ),
              buildPage(
                screenWidth: MediaQuery.of(context).size.width,
                screenHeight: MediaQuery.of(context).size.height,
                title: AppStrings.mainFeature2,
                description: AppStrings.mainFeatureDiscription2,
              ),
              buildPage(
                screenWidth: MediaQuery.of(context).size.width,
                screenHeight: MediaQuery.of(context).size.height,
                title: AppStrings.mainFeature3,
                description: AppStrings.mainFeatureDiscription3,
              ),
            ],
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            left: MediaQuery.of(context).size.width * 0.05,
            child: Obx(() {
              return _controller.currentPage.value < 2
                  ? TextButton(
                      onPressed: () => _controller.skip(),
                      child: Text(
                        AppStrings.skip,
                        style: TextStyle(
                          color: _controller.currentPage.value == 0
                              ? MyColors.green
                              : Colors.grey,
                        ),
                      ),
                    )
                  : const SizedBox.shrink();
            }),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.05,
            right: MediaQuery.of(context).size.width * 0.05,
            child: Obx(() {
              return IconButton(
                icon: SvgPicture.asset(
                  _controller.currentPage.value == 0
                      ? Assets.rightarrow1
                      : Assets.rightarrow1,
                  color: MyColors.green,
                ),
                onPressed: () => _controller.goToNextPage(_pageController),
              );
            }),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.07,
            left: 0,
            right: 0,
            child: Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.01),
                    height: MediaQuery.of(context).size.height * 0.01,
                    width: MediaQuery.of(context).size.width * 0.02,
                    decoration: BoxDecoration(
                      color: _controller.currentPage.value == index
                          ? Colors.green
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.02),
                    ),
                  );
                }),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget buildPage(
      {required double screenWidth,
      required double screenHeight,
      required String title,
      required String description}) {
    return Padding(
      padding: EdgeInsets.all(screenWidth * 0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.conatiner,
            width: screenWidth * 0.8,
            height: screenWidth * 0.8,
          ),
          SizedBox(height: screenHeight * 0.04),
          Text(
            title,
            style: TextStyle(
              fontSize: screenWidth * 0.06,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: MyColors.blackText,
            ),
          ),
        ],
      ),
    );
  }
}























// // ignore_for_file: prefer_final_fields, use_key_in_widget_constructors, library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:project_5240_frontend/presentation/constants/colors.dart';
// import 'package:project_5240_frontend/presentation/constants/strings.dart';
// import 'package:project_5240_frontend/presentation/screens/auth/welcome_screen.dart';

// import '../../constants/assets.dart';

// class OnboardingScreen extends StatefulWidget {
//   @override
//   _OnboardingScreenState createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   PageController _pageController = PageController(initialPage: 0);
//   int _currentPage = 0;

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var screenWidth = MediaQuery.of(context).size.width;
//     var screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView(
//             controller: _pageController,
//             onPageChanged: (int page) {
//               setState(() {
//                 _currentPage = page;
//               });
//             },
//             children: [
//               buildPage(
//                 screenWidth: screenWidth,
//                 screenHeight: screenHeight,
//                 title: AppStrings.mainFeature,
//                 description: AppStrings.mainFeatureDiscription,
//               ),
//               buildPage(
//                 screenWidth: screenWidth,
//                 screenHeight: screenHeight,
//                 title: AppStrings.mainFeature2,
//                 description: AppStrings.mainFeatureDiscription2,
//               ),
//               buildPage(
//                 screenWidth: screenWidth,
//                 screenHeight: screenHeight,
//                 title: AppStrings.mainFeature3,
//                 description: AppStrings.mainFeatureDiscription3,
//               ),
//             ],
//           ),
//           Positioned(
//             bottom: screenHeight * 0.05,
//             left: screenWidth * 0.05,
//             child: _currentPage < 2
//                 ? TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           (MaterialPageRoute(
//                               builder: (context) => const WelcomeScreen())));
//                       // Handle Skip button press
//                     },
//                     child: Text(
//                       AppStrings.skip,
//                       style: TextStyle(
//                         color: _currentPage == 0 ? MyColors.green : Colors.grey,
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(),
//           ),
//           Positioned(
//             bottom: screenHeight * 0.05,
//             right: screenWidth * 0.05,
//             child: IconButton(
//               icon: SvgPicture.asset(
//                 _currentPage == 0 ? Assets.greenIcon : Assets.rightarrow1,
//                 color: MyColors.green,
//               ),
//               onPressed: () {
//                 if (_currentPage < 2) {
//                   _pageController.nextPage(
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeIn,
//                   );
//                   debugPrint("0000000000000000000");
//                 } else {
//                   debugPrint("0000000000000000000");
//                 }
//               },
//             ),
//           ),
//           Positioned(
//             bottom: screenHeight * 0.07,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(3, (index) {
//                 return AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
//                   height: screenHeight * 0.01,
//                   width: screenWidth * 0.02,
//                   decoration: BoxDecoration(
//                     color: _currentPage == 0
//                         ? Colors.green
//                         : (_currentPage == index ? Colors.green : Colors.grey),
//                     borderRadius: BorderRadius.circular(screenWidth * 0.02),
//                   ),
//                 );
//               }),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget buildPage(
//       {required double screenWidth,
//       required double screenHeight,
//       required String title,
//       required String description}) {
//     return Padding(
//       padding: EdgeInsets.all(screenWidth * 0.1),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             Assets.conatiner,
//             width: screenWidth * 0.8,
//             height: screenWidth * 0.8,
//           ),
//           SizedBox(height: screenHeight * 0.04),
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: screenWidth * 0.06,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           SizedBox(height: screenHeight * 0.03),
//           Text(
//             description,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: screenWidth * 0.03,
//               color: MyColors.blackText,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
