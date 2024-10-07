// ignore: prefer_const_constructors
// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/auth_tab/controller/auth_tab_controller.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/login/view/login_screen.dart';
import '../create/view/create_account_screen.dart';
import 'package:get/get.dart';

class AuthTabScren extends StatefulWidget {
  final int currentIndex;
  const AuthTabScren({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<AuthTabScren> createState() => _AuthTabScrenState();
}

class _AuthTabScrenState extends State<AuthTabScren>
    with SingleTickerProviderStateMixin {
  final AuthTabController loginController = Get.put(AuthTabController());

  late TabController _tabController;
  final AuthTabController authTabController = Get.put(AuthTabController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
        length: 2, initialIndex: widget.currentIndex, vsync: this);
    authTabController.setTabController(_tabController);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sized = MediaQuery.of(context).size;
    return GetBuilder<AuthTabController>(builder: (controller) {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: sized.height * 0.68,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(255, 255, 255, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(36),
                    topRight: Radius.circular(36),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Container(
                      height: 6,
                      width: 48,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: const Color.fromRGBO(210, 212, 216, 1),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      height: 50,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        height: 70,
                        child: TabBar(
                          onTap: (index) {
                            loginController.setPageIndex(index.toInt());
                            loginController.update();
                          },
                          controller: _tabController,
                          dividerColor: Colors.transparent,
                          indicatorColor: AppColors.green,
                          tabs: [
                            Text(
                              "Create Account",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _tabController.index == 0
                                    ? AppColors.green
                                    : AppColors.black,
                              ),
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: _tabController.index == 1
                                    ? AppColors.green
                                    : AppColors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child:
                          GetBuilder<AuthTabController>(builder: (controller) {
                        return TabBarView(
                          controller: _tabController,
                          children: [
                            const CreateAccountScreen(),
                            LoginScreen(),
                          ],
                        );
                      }),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class Indigator extends StatelessWidget {
  final String? text;
  final double? width;
  final TextStyle? style;
  final bool isActive;
  final void Function()? onTap;

  const Indigator({
    super.key,
    this.text,
    this.width,
    this.style,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text ?? "",
            textAlign: TextAlign.center,
            style: style ??
                TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: isActive
                      ? const Color.fromRGBO(50, 183, 104, 1)
                      : const Color.fromRGBO(137, 144, 158, 1),
                ),
          ),
          isActive
              ? Container(
                  width: width,
                  padding: const EdgeInsets.only(top: 5),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 2,
                        color: Color.fromRGBO(50, 183, 104, 1),
                      ),
                    ),
                  ),
                )
              : const SizedBox()
        ],
      ),
    );
  }
}


// class RegisterScreen extends StatefulWidget {
//   const RegisterScreen({super.key});

//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }

// class _RegisterScreenState extends State<RegisterScreen> {
//   PageController pageController = PageController(initialPage: 0);
//   int _currentIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     final sized = MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: const Color.fromRGBO(217, 217, 217, 1),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             height: sized.height * 0.68,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//               color: Color.fromRGBO(255, 255, 255, 1),
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(36),
//                 topRight: Radius.circular(36),
//               ),
//             ),
//             child: Column(
//               children: [
//                 const SizedBox(height: 10),
//                 Container(
//                   height: 6,
//                   width: 48,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(6),
//                     color: const Color.fromRGBO(210, 212, 216, 1),
//                   ),
//                 ),
//                 const SizedBox(height: 40),
//                 Container(
//                   height: 50,
//                   margin: const EdgeInsets.only(left: 40, right: 80),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Indigator(
//                         onTap: () {
//                           pageController.animateToPage(0,
//                               curve: Curves.bounceOut,
//                               duration: const Duration(microseconds: 1));
//                         },
//                         text: "Create Account",
//                         width: 77,
//                         isActive: _currentIndex == 0 ? true : false,
//                       ),
//                       Indigator(
//                         onTap: () {
//                           pageController.animateToPage(1,
//                               curve: Curves.bounceOut,
//                               duration: const Duration(microseconds: 1));
//                         },
//                         width: 28,
//                         text: "Login",
//                         isActive: _currentIndex == 1 ? true : false,
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 Expanded(
//                   child: MultiBlocProvider(
//                     providers: [
//                       BlocProvider<LoginBloc>(
//                         create: (BuildContext context) => LoginBloc(),
//                       ),
//                     ],
//                     child: PageView(
//                       physics: const PageScrollPhysics(
//                           parent: NeverScrollableScrollPhysics()),
//                       onPageChanged: (value) {
//                         setState(() {
//                           _currentIndex = value;
//                         });
//                       },
//                       controller: pageController,
//                       children: [
//                         const CreateAccountScreen(),
//                         LoginScreen(),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class Indigator extends StatelessWidget {
//   final String? text;
//   final double? width;
//   final TextStyle? style;
//   final bool isActive;
//   final void Function()? onTap;
//   const Indigator({
//     super.key,
//     this.text,
//     this.width,
//     this.style,
//     this.onTap,
//     this.isActive = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Text(
//             text ?? "",
//             textAlign: TextAlign.center,
//             style: style ??
//                 TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w600,
//                   color: isActive
//                       ? Color.fromRGBO(50, 183, 104, 1)
//                       : Color.fromRGBO(137, 144, 158, 1),
//                 ),
//           ),
//           isActive
//               ? Container(
//                   width: width,
//                   padding: const EdgeInsets.only(top: 5),
//                   decoration: const BoxDecoration(
//                     border: Border(
//                       bottom: BorderSide(
//                         width: 2,
//                         color: Color.fromRGBO(50, 183, 104, 1),
//                       ),
//                     ),
//                   ),
//                 )
//               : const SizedBox()
//         ],
//       ),
//     );
//   }
// }
