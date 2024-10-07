import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/presentation/domain_side/addsubdomin/basicItems%20_screen.dart';

class BasicItemText extends StatelessWidget {
  final String text;
  final int? listType;
  const BasicItemText({super.key, required this.text, this.listType});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: Color(0xff32343E)),
        ),
        Row(children: [
          const Text(
            'See all',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14,
                color: Color(0xff9C9BA6)),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.to(BasicItemsView(listType: listType));
            },
            icon: const Icon(Icons.arrow_right_sharp),
          )
        ])
      ],
    );
  }
}
