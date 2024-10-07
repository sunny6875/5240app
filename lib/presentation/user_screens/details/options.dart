// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/presentation/user_screens/details/subdomin/subdomain.dart';

class Options extends StatelessWidget {
  const Options({super.key, required this.domain});
  final Map<String, dynamic> domain;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: screenHeight * 0.043,
        ),
        const Text(
          'Option',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
              color: Color(0xff1C1C1C)),
        ),
        SizedBox(
          height: screenHeight * 0.029,
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8, // Aspect ratio for each item
            ),
            itemCount: domain['subdomains'].length,
            itemBuilder: (context, index) {
              var location = domain['location'] is String
                  ? domain['location'] // If it's a String, show it directly
                  : domain['location']['name'] ?? '';
              var subdomain = domain['subdomains'][index];
              List<String> imageUrls = List<String>.from(
                  subdomain['image'] ?? []); // Fetch images from subdomain

              String displayImageUrl = imageUrls.isNotEmpty
                  ? imageUrls[0] // Display the first image
                  : 'https://via.placeholder.com/283x156'; // Placeholder if no images are available

              return GestureDetector(
                onTap: () {
                  Get.to(() => SubdomainScreen(
                        domainId: domain['_id'],
                        subdomainId: subdomain['_id'],
                        location: location,
                      ));
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                            color: Colors.black, width: 1),
                        color: Colors.grey,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.network(
                          displayImageUrl,
                          fit: BoxFit.cover,
                          height: 60,
                          width: 60,
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                                child: Icon(Icons.error, color: Colors.red));
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                                child: CircularProgressIndicator());
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Text(
                        subdomain['title'],
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Color(0xff1C1C1C),
                        ),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
