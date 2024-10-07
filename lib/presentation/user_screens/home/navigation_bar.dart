// ignore_for_file: prefer_const_constructors

import 'package:project_5240_frontend/config/themes/theme.dart';
import 'package:project_5240_frontend/presentation/domain_side/domin_home/domain_home_widget.dart';
import 'package:project_5240_frontend/presentation/domain_side/domain_search.dart';
import 'package:project_5240_frontend/presentation/user_screens/accounts/account_screen.dart';
import 'package:project_5240_frontend/presentation/user_screens/accounts/controller/account_controller.dart';
import 'package:project_5240_frontend/presentation/user_screens/home/explore_domain/explore_domain_screen.dart';
import 'package:project_5240_frontend/presentation/user_screens/home/main_home_screen.dart';
import 'package:project_5240_frontend/presentation/user_screens/map_screens/map_screen.dart';
import 'package:project_5240_frontend/utils/extension.dart';
import '../../domain_side/addsubdomin/add_subdomin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool? isProvider; // This will store the provider state
  List<Widget> _pageData = [];
  final ExploreDomainController domainController =
      Get.put(ExploreDomainController()); // Declare without initializing

  final AccountController accountController = Get.put(AccountController());

  @override
  void initState() {
    super.initState();
    _checkProviderStatus(); // Initialize the check for provider status
    accountController.getProfileData();
  }

  // Asynchronous function to get provider status
  Future<void> _checkProviderStatus() async {
    final provider = await LocalStore.getIsProvider();
    setState(() {
      isProvider = provider;
      debugPrint("Provider===================>$isProvider");
      _pageData = isProvider == true
          ? [
              DomainHomeWidget(),
              DomainSearchWidget(),
              AddSubdomin(),
              AccountScreen(
                isActive: false,
              ),
            ]
          : [
              MainHomeScreen(),
              ExploreDomainScreen(),
              MapScreen(),
              AccountScreen(
                isActive: true,
              ),
            ];
    });
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    AppTheme.setLightThemeSystemUI();
    return Scaffold(
      body: _pageData[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentPage,
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.white,
        selectedItemColor: AppColors.green,
        unselectedItemColor: AppColors.greyNav,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/home.png",
              height: 24,
              width: 24,
              color: currentPage == 0 ? AppColors.green : AppColors.greyNav,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/search-normal.png",
              height: 24,
              width: 24,
              color: currentPage == 1 ? AppColors.green : AppColors.greyNav,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              isProvider == true
                  ? "assets/images/shop.png"
                  : "assets/images/map.png",
              height: 24,
              width: 24,
              color: currentPage == 2 ? AppColors.green : AppColors.greyNav,
            ),
            label: isProvider == true ? "Shop" : "Map",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/user.png",
              height: 24,
              width: 24,
              color: currentPage == 3 ? AppColors.green : AppColors.greyNav,
            ),
            label: "Profile",
          ),
        ],
        onTap: (index) {
          setState(() {
            if (index == 1) {
              domainController.mostviewfetchDomains();
            }
            currentPage = index;
          });
        },
      ),
    );
  }
}
