// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:semicircle_indicator/semicircle_indicator.dart';

class ApprovalScreen extends StatefulWidget {
  const ApprovalScreen({super.key});

  @override
  State<ApprovalScreen> createState() => _ApprovalScreenState();
}

class _ApprovalScreenState extends State<ApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return const Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      SemicircularIndicator(
        color: Color(0xff32B768),
        bottomPadding: 0,
        child: Text(
          '72%',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 44,
              color: Color(0xff1F2937)),
        ),
      ),
      Text(
        'By Customers',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color(0xff1F2937)),
      ),
      Text(
        'Lorem ipsum dolor sit',
        style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xff1F2937)),
      )
    ]));
  }
}
