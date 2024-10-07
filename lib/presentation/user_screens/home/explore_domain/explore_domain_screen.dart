import 'package:cached_network_image/cached_network_image.dart';
import '../../details/details.dart';
import '../../../../utils/extension.dart';
import '../../accounts/account_screen.dart';
import '../../accounts/controller/account_controller.dart';
import '../../explore_category/filter_bottomsheet.dart';

class ExploreDomainScreen extends StatefulWidget {
  final String? categoryIds;

  const ExploreDomainScreen({super.key, this.categoryIds});

  @override
  State<ExploreDomainScreen> createState() => _ExploreDomainScreenState();
}

class _ExploreDomainScreenState extends State<ExploreDomainScreen> {

  final AccountController accountController = Get.find<AccountController>();
  final DomainController _domainController = Get.put(DomainController());
  final ExploreDomainController domainController = Get.put(ExploreDomainController()); // Declare without initializing

  // Controller to manage search input
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    domainController.getCategoryDat();
  }

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(AccountScreen());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider(
                    accountController.profileModel?.user?.userProfile ?? ""),
              ),
            ),
          )
        ],
        backgroundColor: const Color(0xffFFFFFF),
        title: Obx(() {
          if (domainController.isLoading.value) {
            return const Text('Loading...');
          }
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_pin),
              Flexible(
                child: Text(
                  _domainController.currentLocation?.value ?? 'location',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff4B5563),
                  ),
                ),
              ),
            ],
          );
        }),
        centerTitle: true,
      ),
      body: Obx(() {
        if (domainController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        // Filtered domain list based on search input
        final filteredDomainList = domainController.domainList.where((domain) {
          final searchText = searchController.text.toLowerCase();
          return domain['title'].toLowerCase().contains(searchText);
        }).toList();

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Explore Domain',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: TextField(
                  controller: searchController, // Use the controller
                  onChanged: (value) {
                    // Force rebuild to update filtered list
                    domainController.searchFilter(value);
                    domainController.update();
                    // Force rebuild to update filtered list
                  },
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Search...',
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
              ),

              Row(
                children: [
                  SizedBox(
                    height: screenHeight * 0.043,
                    width: screenWidth * 0.8,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: domainController.categorylist.length,
                      itemBuilder: (context, index) {
                        var category =
                            domainController.categorylist[index];
                        return GestureDetector(
                          onTap: () {
                            domainController.fetchDomainDetails(category['_id'].toString());
                            // Handle subdomain selection logic
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15),
                            height: screenHeight * 0.034,
                            width: screenWidth * 0.234,
                            decoration: BoxDecoration(
                              color: const Color(0xff32B768),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Center(
                              child: Text(
                                category['categoryName'].toString(),
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xffFFFFFF),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        barrierColor: Colors.black.withOpacity(0.8),
                        backgroundColor: Colors.white,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            topLeft: Radius.circular(30),
                          ),
                        ),
                        builder: (BuildContext context) {
                          return const FractionallySizedBox(
                            heightFactor: 0.8,
                            child: FilterBottomSheet(),
                          );
                        },
                      );
                    },
                    child: const Icon(Icons.filter_alt_outlined),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              const Text('Check your city Near by Doamin'),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredDomainList.length,
                  itemBuilder: (context, index) {
                    final domain = filteredDomainList[index];
                    return CustomComponent(
                      imageUrl: domain['image'][0],
                      text: domain['title'],
                      location: domain['location'] != null
                          ? domain['location']['name']
                          : 'Unknown Location',
                      buttonText: 'View',
                      onButtonPressed: () {
                        Get.to(() => DetailsScreen(domain: domain));
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class CustomComponent extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String location;
  final String buttonText;
  final VoidCallback onButtonPressed;

  const CustomComponent({
    super.key,
    required this.imageUrl,
    required this.text,
    required this.location,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: const Color(0xff222222).withOpacity(0.2),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Image.network(
            imageUrl,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff4B5563),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.location_pin, color: Colors.green),
                    Expanded(
                      child: Text(
                        location,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: onButtonPressed,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xff32B768),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                buttonText,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xffFFFFFF),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
