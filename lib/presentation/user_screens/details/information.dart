// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:project_5240_frontend/presentation/user_screens/map_screens/map_screen.dart';

import '../../../utils/extension.dart';
import '../../constants/assets.dart';

class InformationScreen extends StatelessWidget {
  final Map<String, dynamic> domain;

  const InformationScreen({super.key, required this.domain});

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screenheight * 0.026,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.clock),

                    SizedBox(
                      width: screenWidth * 0.013,
                    ),
                    const Text('Open today',
                        style: TextStyle(
                          color: Color(0xff6B7280),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        )),

                  ],
                ),
                Text( domain['opening']??'10:00 AM',
                    style: const TextStyle(
                      //    decoration: TextDecoration.underline,
                      color: Color(0xff1F2937),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    )),
              ],
            ),


            Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(Assets.clock),

                    SizedBox(
                      width: screenWidth * 0.013,
                    ),
                    const Text('Close today',
                        style: TextStyle(
                          color: Color(0xff6B7280),
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        )),

                  ],
                ),
                Text( domain['closing']??'10:00 AM',
                    style: const TextStyle(
                      //    decoration: TextDecoration.underline,
                      color: Color(0xff1F2937),
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    )),
              ],
            ),
          ],
        ),
        SizedBox(
          height: screenheight * 0.01,
        ),

        SizedBox(
          height: screenheight * 0.026,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('2.5 Km . 5 Mins',
                style: TextStyle(
                  //    decoration: TextDecoration.underline,
                  color: const Color(0xff65656580).withOpacity(0.5),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                )),
            SizedBox(
              width: screenWidth * 0.01,
            ),

            GestureDetector(
              onTap: () {
                Get.to(const MapScreen());
              },
              child: Row(
                children: [
                  SvgPicture.asset(Assets.direction),

                  const Text('Visit the Doamin',
                      style: TextStyle(
                        color: Color(0xff2C8DFF),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      )),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: 20,),
        Text(
          domain['title'],
          style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xff1F2937)),
        ),
        const Text(
          textAlign: TextAlign.justify,
          'Description',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Color(0xff5E5E5E)),
        ),
        SizedBox(
          height: screenheight * 0.011,
        ),
        Text(
          textAlign: TextAlign.justify,
          domain['description'] ??
              'Lorem ipsum dolor sit amet consectetur. Dolor vivamus fermentum pretium sit ut consequat et et ultrices. At amet vel pharetra a tincidunt sagittis aliquam in amet tortor.',
          style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0xff5E5E5E)),
        ),
        SizedBox(
          height: screenheight * 0.011,
        ),
      ],
    );
  }
}
