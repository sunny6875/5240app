import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/welcome_screen.dart';

class OnboardingController extends GetxController {
  var currentPage = 0.obs; // Observable variable for current page index

  void setPage(int page) {
    currentPage.value = page;
  }

  void goToNextPage(PageController pageController) {
    if (currentPage.value < 2) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Get.to(() => const WelcomeScreen());
    }
  }

  void skip() {
    Get.to(() => const WelcomeScreen());
  }
}
