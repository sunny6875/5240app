import 'package:flutter/services.dart';
import 'package:project_5240_frontend/utils/extension.dart';

class AppTheme {
  // Light theme data
  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent, backgroundColor: AppColors.white),
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.white,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.white,
    ),
    useMaterial3: true,
  );

  // Dark theme data
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.black,
  );

  // Method to set the status bar and navigation bar color
  static void setLightThemeSystemUI() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, // Transparent status bar
        statusBarIconBrightness: Brightness.dark, // Dark icons for light theme
        statusBarBrightness: Brightness.light, // For iOS
        systemNavigationBarColor: AppColors.white, // Navigation bar color
        systemNavigationBarIconBrightness:
            Brightness.dark, // Dark icons for nav bar
      ),
    );
  }
}
