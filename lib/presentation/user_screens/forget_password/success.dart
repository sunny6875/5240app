import 'package:lottie/lottie.dart';
import 'package:project_5240_frontend/presentation/user_screens/auth/auth_tab/auth_tab_screen.dart';
import 'package:project_5240_frontend/utils/extension.dart';
import '../../widgets/custom_btn.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          children: [
            CustomizeButton(
              color: const Color(0xFF32B768),
              textColor: Colors.white,
              onTap: () {
                Get.offAll(const AuthTabScren(currentIndex: 1));
              },
              width: screenWidth * 0.7,
              text: 'Sign in',
              height: screenheight * 0.060,
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: screenheight * 0.04,
              ),
              Lottie.asset('assets/images/success.json',
                  height: 200, width: 200),
              const SizedBox(height: 15),
              const Text(
                "Success",
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff374151)),
              ),
              const SizedBox(height: 10),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  textAlign: TextAlign.center,
                  "Congratulations your password has\nbeen changed,",
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff828282)),
                ),
              ),
              const SizedBox(height: 40),
            ]),
      ),
    );
  }
}
