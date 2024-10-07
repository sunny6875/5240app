import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/presentation/constants/assets.dart';
import 'package:project_5240_frontend/presentation/domain_side/adddomin/edit_domain_screen.dart';
import 'package:project_5240_frontend/presentation/user_screens/accounts/controller/account_controller.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/auth_tab/auth_tab_screen.dart';
import 'package:project_5240_frontend/utils/local_store.dart';
import '../comming_soon/comming_soon.dart';
import '../notification/notification_screen.dart';
import 'edit_profile_screen.dart';
import 'language_widget.dart';

class AccountScreen extends StatelessWidget {
  final bool? isActive;
  AccountScreen({super.key, this.isActive});
  final accountController = Get.put(AccountController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountController>(builder: (controller) {
      return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: CachedNetworkImageProvider(
                              controller.profileModel?.user?.userProfile ??
                                  "https://cdn-icons-png.flaticon.com/128/4140/4140037.png",
                              errorListener: (p0) => const Icon(Icons.person),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Obx(
                            () => Expanded(
                              flex: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.name.value,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff374151)),
                                  ),
                                  Text(
                                    controller.email.value,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xff374151)),
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.to(NotificationScreen());
                            },
                            child: Container(
                                margin: const EdgeInsets.only(right: 10),
                                decoration: const BoxDecoration(
                                  color: Color(0xffF9F9F9),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                height: 44,
                                width: 44,
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      Assets.notification,
                                      width: 20.0,
                                      height: 20.0,
                                    ),
                                    if (3 > 0)
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(1.0),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          constraints: const BoxConstraints(
                                            minWidth: 15,
                                            minHeight: 7,
                                          ),
                                          child: const Text(
                                            '3',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  _cardView(
                      title: "Account setting",
                      onTap: () {
                        Get.to(EditProfileScreen());
                      }),
                  const SizedBox(height: 20),
                  controller.profileModel?.user?.isDomainProvider == true
                      ? _cardView(
                          title: "Edit Domain",
                          child: const Icon(Icons.domain),
                          onTap: () {
                            Get.to(EditDomainScreen());
                          })
                      : const SizedBox.shrink(),
                  controller.profileModel?.user?.isDomainProvider == true
                      ? const SizedBox(height: 20)
                      : const SizedBox.shrink(),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                    shadowColor: Colors.white,
                    color: Colors.white,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .3,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LanguageWidget()),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.messageA,
                                  width: 17,
                                  height: 15,
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  "Language",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff374151)),
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  Assets.rightarrow,
                                  width: 15.0,
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              Get.to(const ComingSoonScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.message,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  "Feedback",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff374151)),
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  Assets.rightarrow,
                                  width: 15.0,
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(const ComingSoonScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.star,
                                  width: 20,
                                  height: 20,
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  "Rate us",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff374151)),
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  Assets.rightarrow,
                                  width: 15.0,
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () {
                              Get.to(const ComingSoonScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  Assets.uparrowwithroundcircle,
                                  width: 22,
                                  height: 22.0,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  "New Version",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff374151)),
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  Assets.rightarrow,
                                  width: 15.0,
                                  height: 15.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      LocalStore.clearUserData().then((value) =>
                          Get.offAll(const AuthTabScren(currentIndex: 1)));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 25, right: 25, bottom: 5, top: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xff32B768),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 20,
                        minHeight: 20,
                      ),
                      child: const Text(
                        'Logout',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }

  Widget _cardView({
    void Function()? onTap,
    String? title,
    Widget? child,
  }) {
    return SizedBox(
      height: 70,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      child ??
                          SvgPicture.asset(
                            Assets.profile,
                            width: 25.0,
                            height: 25.0,
                          ),
                      const SizedBox(width: 15),
                      Text(
                        title ?? "",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff374151)),
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    Assets.write,
                    width: 20.0,
                    height: 20.0,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
