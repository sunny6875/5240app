import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import 'package:project_5240_frontend/config/routes/app_page.dart';
import 'package:project_5240_frontend/config/routes/app_router.dart';
import 'package:project_5240_frontend/config/themes/theme.dart';
import 'package:project_5240_frontend/data/client/baseclient/base_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BaseClient.initialize("https://project5240.zatest.biz");
  bool isAuth = await BaseClient.isAuthenticated();
  runApp(MyApp(isAuth: isAuth));
}

class MyApp extends StatelessWidget {
  final bool? isAuth;
  const MyApp({super.key, this.isAuth});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return GetMaterialApp(
          title: 'My Project',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          themeMode: ThemeMode.light,
          initialRoute:
              isAuth == true ? AppRoutes.homeScreen : AppRoutes.onboard,
          getPages: AppPage.page,
        );
      },
      //child: OnboardingScreen(),
    );
  }
}
