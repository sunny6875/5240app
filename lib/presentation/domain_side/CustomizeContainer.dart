// ignore_for_file: unused_local_variable, prefer_const_constructors, library_private_types_in_public_api, prefer_final_fields

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CircleContainer extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  final Color color;
  final Color borderColor;
  final VoidCallback onTap;
  const CircleContainer(
      {super.key,
      required this.height,
      required this.width,
      required this.text,
      required this.color,
      required this.onTap,
      required this.borderColor});

  @override
  Widget build(BuildContext context) {
    var screenheight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
              height: height,
              width: width,
              // height: screenheight * 74 / 814,
              // width: screenWidth * 74 / 375,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
                //   // 20% opacity color
                border: Border.all(
                  width: 0.72, // Border width
                  color: borderColor, // Transparent border
                ),
              )),
        ),
        SizedBox(
          height: screenheight * 0.0015,
        ),
        Text(
          text,
          style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Color(0xff000000)),
        )
      ],
    );
  }
}

class CustomizeContainer extends StatefulWidget {
  final double height;
  final Widget image;
  final double width;
  final String text;

  const CustomizeContainer({
    super.key,
    required this.height,
    required this.width,
    required this.image,
    required this.text,
  });

  @override
  _CustomizeContainerState createState() => _CustomizeContainerState();
}

class _CustomizeContainerState extends State<CustomizeContainer> {
  ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = pickedFile;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _pickImage,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xffE8EAED), width: 1),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_selectedImage != null)
                  Image.file(
                    File(_selectedImage!.path),
                    height: widget.height * 0.9,
                    width: widget.width * 0.9,
                    fit: BoxFit.cover,
                  )
                else ...[
                  widget.image,
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: Color(0xff9C9BA6),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ]),
        ),
      ),
    );
  }
}
