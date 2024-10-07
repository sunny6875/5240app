import 'package:get/get.dart';
import 'package:project_5240_frontend/config/routes/app_router.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/create/binding/craete_binding.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/create/view/create_account_screen.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/login/binding/login_binding.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/login/view/login_screen.dart';
import 'package:project_5240_frontend/presentation/user_screens/forget_password/verify/binding/verify_binding.dart';
import 'package:project_5240_frontend/presentation/user_screens/forget_password/verify/view/verify_otp_screen.dart';
import 'package:project_5240_frontend/presentation/user_screens/home/navigation_bar.dart';
import 'package:project_5240_frontend/presentation/user_screens/onboarding/onboard_screen.dart';


class AppPage {
  static List<GetPage> page = [
    GetPage(
      name: AppRoutes.onboard,
      page: () => OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.loginScreen,
      binding: LoginBinding(),
      page: () => LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.createAccountScreen,
      binding: CreateBinding(),
      page: () => const CreateAccountScreen(),
    ),
    // GetPage(
    //   name: AppRoutes.exploredomain,
    //   binding: ExploreDominBinding(),
    //   page: () => ExploreDomainScreen(
    //     categoryId: '',
    //   ),
    // ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
    ),
    GetPage(
      name: AppRoutes.verifyOTPScreen,
      binding: VerifyBinding(),
      page: () => const VerifyOTPScreen(),
    ),
  ];
}
