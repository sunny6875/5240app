import 'package:flutter/material.dart';

class SlideContainer extends StatelessWidget {
  final String imageUrl; // Accept image URL

  const SlideContainer({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      width: screenWidth * 327 / 375,
      height: screenHeight * .210,
      decoration: BoxDecoration(
        color: const Color(0xff00000033).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl), // Display the image from URL
          fit: BoxFit.cover, // Fit the image properly in the container
        ),
      ),
    );
  }
}
