import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_5240_frontend/presentation/user_screens/details/subdomin/subdomin_controller/subdomin_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../widgets/slide_container.dart';

class SubdomainScreen extends StatelessWidget {
  final String domainId;
  final String subdomainId;
  final String location;

  const SubdomainScreen({
    super.key,
    required this.domainId,
    required this.subdomainId,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final PageController pageController = PageController();

    // Initialize the controller with the IDs
    final SubdomainController subdomainController =
        Get.put(SubdomainController(domainId, subdomainId));

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Subdomain Details',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 17,
                color: Color(0xff181C2E),
              ),
            ),

          ],
        ),
        centerTitle: false,
      ),
      body: Obx(() {
        if (subdomainController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        var subdomainData = subdomainController.subdomainDetails;
        print('----------------------------------${subdomainData.toString()}');

        // Access the first subdomain
        var subdomainList = subdomainData['subdomains'] as List<dynamic>?;
        var firstSubdomain =
            subdomainList?.isNotEmpty == true ? subdomainList![0] : null;

        String singleImageUrl = (firstSubdomain?['image'] as List<dynamic>?)
                    ?.isNotEmpty ==
                true
            ? firstSubdomain['image'][0]
            : 'https://via.placeholder.com/150'; // Placeholder if no images are available

        List<String> imageUrls = firstSubdomain != null
            ? List<String>.from(firstSubdomain['image'] ?? [])
            : [singleImageUrl]; // Add images from the first subdomain
        var basicItemList = firstSubdomain?['basicItemId'] as List<dynamic>?;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * .045),
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: screenWidth * 327 / 375,
                      height: screenHeight * .210,
                      decoration: BoxDecoration(
                        color: const Color(0xff98A8B8),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: PageView(
                        controller: pageController,
                        children: imageUrls.map((imageUrl) {
                          return SlideContainer(
                            imageUrl: imageUrl,
                          );
                        }).toList(),
                      ),
                    ),
                  ),


                ],
              ),
              SizedBox(height: screenHeight * .013),
              Text(
                firstSubdomain?['title'].toString() ?? 'Subdomain',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xff32343E),
                ),
              ),
              SizedBox(height: screenHeight * .014),
              Row(
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Color(0xffAFAFAF),
                  ),
                  Text(
                    location,
                    style: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      color: Color(0xffAFAFAF),
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * .020),
              if (basicItemList != null && basicItemList.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: basicItemList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Show 5 items per row
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                    childAspectRatio: 1, // Adjust the aspect ratio if needed
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    var item = basicItemList[index];
                    return Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            item['icon'].toString() ?? 'https://via.placeholder.com/50',
                            fit: BoxFit.cover,
                            width: 52,
                            height: 52,
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Icon(Icons.error, color: Colors.red),
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['name'].toString() ?? 'Unknown Item',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: Color(0xff1C1C1C),
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    );
                  },
                ),
              SizedBox(height: screenHeight * .020),
              const Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: Color(0xff32343E),
                ),
              ),
              SizedBox(height: screenHeight * .014),
              Text(
                firstSubdomain?['description'].toString() ?? 'No description available.',
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: Color(0xff747783),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
