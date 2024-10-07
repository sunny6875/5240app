import 'package:flutter/material.dart';
import 'package:project_5240_frontend/presentation/widgets/textfield.dart';

import '../../widgets/CustomizeContainer.dart';

class BasicItems extends StatefulWidget {
  const BasicItems({super.key});

  @override
  State<BasicItems> createState() => _BasicItemsState();
}

class _BasicItemsState extends State<BasicItems> {
  List<bool> isSelected = List.generate(36, (_) => false);

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    TextEditingController searchController = TextEditingController();

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
        leading: const Icon(Icons.arrow_back),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Basic Lorem',
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
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
                'ITEM NAME',
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
                  hinttext: 'Search Item name', controller: searchController),
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
            const Text(
              'Basic',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xff32343E)),
            ),
            SizedBox(
              height: screenheight * 0.022,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              List.generate(6, (index) => buildCircleContainer(index)),
            ),
            SizedBox(
              height: screenheight * 0.013,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              List.generate(6, (index) => buildCircleContainer(index + 6)),
            ),
            SizedBox(
              height: screenheight * 0.019,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              List.generate(6, (index) => buildCircleContainer(index + 12)),
            ),
            SizedBox(
              height: screenheight * 0.019,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              List.generate(6, (index) => buildCircleContainer(index + 18)),
            ),
            SizedBox(
              height: screenheight * 0.019,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:
              List.generate(6, (index) => buildCircleContainer(index + 24)),
            ),
            SizedBox(
              height: screenheight * 0.019,
            ),
          ],
        ),
      ),
    );
  }
}