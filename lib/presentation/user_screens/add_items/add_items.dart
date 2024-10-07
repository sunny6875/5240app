import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:project_5240_frontend/presentation/widgets/Customize_text/basic_item.dart';
import 'package:project_5240_frontend/presentation/widgets/textfield.dart';
import '../../constants/assets.dart';
import '../../widgets/CustomizeContainer.dart';
import '../../widgets/custom_btn.dart';

class AddItemsScreen extends StatefulWidget {
  const AddItemsScreen({super.key});

  @override
  State<AddItemsScreen> createState() => _AddItemsScreenState();
}

class _AddItemsScreenState extends State<AddItemsScreen> {
  List<bool> isSelected = List.generate(11, (_) => false);

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    Widget buildCircleContainer(int index) {
      return CircleContainer(
        onTap: () {
          setState(() {
            isSelected[index] = !isSelected[index];
          });
        },
        borderColor: isSelected[index] ? Colors.transparent : const Color(0xffE8EAED),
        color: isSelected[index]
            ? const Color(0xff32B768).withOpacity(0.4)
            : const Color(0xffFDFDFD),
        text: '11',
        height: screenheight * 50 / 814,
        width: screenWidth * 50 / 375,
      );
    }

    return Scaffold(
        appBar: AppBar(
          leading: SvgPicture.asset(Assets.cloudIc),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Add New Items',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 17,
                    color: Color(0xff181C2E)),
              ),
              Text(
                'RESET',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff32B768),
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff32B768)),
              ),
            ],
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'ADD SUBDOMAIN',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color(0xff32343E)),
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.008,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomizeTextField(
                          hinttext: 'Search Item name',
                          controller: searchController),
                    ),
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                    const Text(
                      'UPLOAD PHOTO/VIDEO',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: Color(0xff32343E)),
                    ),
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomizeContainer(
                            text: 'Add',
                            height: screenheight * 101 / 814,
                            width: screenWidth * 111 / 374,
                            image: SvgPicture.asset(
                              Assets.cloudIc,
                              height: screenheight * 0.06,
                              width: screenWidth * 0.07,
                              fit: BoxFit.contain,
                            )),
                        CustomizeContainer(
                            text: 'Add',
                            height: screenheight * 101 / 814,
                            width: screenWidth * 111 / 374,
                            image: SvgPicture.asset(
                              Assets.cloudIc,
                              height: screenheight * 0.06,
                              width: screenWidth * 0.07,
                              fit: BoxFit.fill,
                            )),
                        CustomizeContainer(
                            text: 'Add',
                            height: screenheight * 101 / 814,
                            width: screenWidth * 111 / 374,
                            image: SvgPicture.asset(
                              Assets.cloudIc,
                              height: screenheight * 0.06,
                              width: screenWidth * 0.07,
                              fit: BoxFit.fill,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'LOREM',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: Color(0xff32343E)),
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.019,
                    ),
                    const BasicItemText(text: 'Basic Item 1'),
                    SizedBox(
                      height: screenheight * 0.022,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          5, (index) => buildCircleContainer(index)),
                    ),
                    SizedBox(
                      height: screenheight * 0.013,
                    ),
                    const BasicItemText(text: 'Basic Item 2'),
                    SizedBox(
                      height: screenheight * 0.022,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                          6, (index) => buildCircleContainer(index + 5)),
                    ),
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                    const Text(
                      'Details',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: Color(0xff32343E)),
                    ),
                    SizedBox(
                      height: screenheight * 0.007,
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFDFDFD),
                            borderRadius: BorderRadius.circular(8),
                            border:
                            Border.all(color: const Color(0xffE8EAED), width: 1)),
                        height: screenheight * 103 / 814,
                        width: screenWidth * 327 / 374,
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adips cing elit. Bibendum in vel, mattis et amet dui mauris turpis.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 12,
                                  color: Color(0xff6B6E82)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.024,
                    ),
                    Center(
                      child: CustomizeButton(
                        color: const Color(0xFF32B768),
                        onTap: () {},
                        width: screenWidth * 294 / 375,
                        text: 'Add',
                        height: screenheight * 54 / 908,
                        textColor: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: screenheight * 0.016,
                    ),
                  ])),
        ));
  }
}