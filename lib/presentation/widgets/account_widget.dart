import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_5240_frontend/presentation/user_screens/accounts/language_widget.dart';

import '../user_screens/accounts/edit_profile_screen.dart';

class AccountWidget extends StatefulWidget {
  const AccountWidget({super.key});

  @override
  State<AccountWidget> createState() => _AccountWidgetState();
}

class _AccountWidgetState extends State<AccountWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
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
                      const CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(
                              'https://via.placeholder.com/140x100')),
                      const SizedBox(
                        width: 15,
                      ),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Username",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff374151)),
                          ),
                          Text(
                            "Example@gmail.com",
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff374151)),
                          )
                        ],
                      ),
                      const Spacer(),
                      Container(
                          margin: const EdgeInsets.only(right: 10),
                          decoration: const BoxDecoration(
                            color: Color(0xffF9F9F9),
                            borderRadius: BorderRadius.all(
                                Radius.circular(
                                    50) //                 <--- border radius here
                                ),
                          ),
                          height: 44,
                          width: 44,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/svg_images/ic_notification.svg',
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
                                      borderRadius: BorderRadius.circular(10.0),
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
                          ) /*InkWell(
                            child: Icon(
                              Icons.notifications_none,
                              color: Colors.black,
                              size: 22,
                            ),
                          )*/
                          ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                shadowColor: Colors.white,
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditProfileScreen()),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svg_images/ic_user.svg',
                          width: 250,
                          height: 25.0,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        const Text(
                          "Account setting",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Color(0xff374151)),
                        ),
                        const Spacer(),
                        SvgPicture.asset(
                          'assets/svg_images/ic_edit.svg',
                          width: 20.0,
                          height: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                shadowColor: Colors.white,
                color: Colors.white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * .2,
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
                                builder: (context) => const LanguageWidget()),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/svg_images/ic_language.svg',
                              width: 17,
                              height: 15,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            const Text(
                              "Language",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff374151)),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              'assets/svg_images/ic_right_arrow.svg',
                              width: 15.0,
                              height: 15.0,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg_images/ic_feedback.svg',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Feedback",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff374151)),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/svg_images/ic_right_arrow.svg',
                            width: 15.0,
                            height: 15.0,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg_images/ic_rate_us.svg',
                            width: 20,
                            height: 20,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          const Text(
                            "Rate us",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff374151)),
                          ),
                          const Spacer(),
                          SvgPicture.asset(
                            'assets/svg_images/ic_right_arrow.svg',
                            width: 15.0,
                            height: 15.0,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/svg_images/ic_new_version.svg',
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
                            'assets/svg_images/ic_right_arrow.svg',
                            width: 15.0,
                            height: 15.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 25, right: 25, bottom: 5, top: 6),
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
              )
            ],
          ),
        ));
  }
}
