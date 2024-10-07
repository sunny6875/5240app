import 'package:flutter/material.dart';
import 'auth_tab/auth_tab_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
            child: Container(
              height: 308,
              width: 308,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 1),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Welcome",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 22,
                    color: Color.fromRGBO(16, 22, 35, 1),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: Text(
                    "Login to enjoy the features we’ve provided, and stay healthy!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color.fromRGBO(113, 119, 132, 1),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 80),
          Column(
            children: [
              MaterialButton(
                minWidth: 256,
                height: 49,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthTabScren(currentIndex: 0),
                      ));
                },
                color: const Color.fromRGBO(50, 183, 104, 1),
                child: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                minWidth: 256,
                height: 49,
                elevation: 0,
                color: const Color.fromRGBO(209, 250, 229, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthTabScren(currentIndex: 1),
                      ));
                },
                child: const Text(
                  "Sign In",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(50, 183, 104, 1),
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 320,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                      text:
                          "By logging in or registering, you have agreed to\t",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                      children: [
                        TextSpan(
                            text: "The Terms And Conditions ",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(50, 183, 104, 1),
                            )),
                        TextSpan(text: "And\t"),
                        TextSpan(
                            text: "Privacy Policy.",
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(50, 183, 104, 1),
                            )),
                      ]),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
