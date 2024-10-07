// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../home/explore_domain/controller/explore_domin_controller.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  double _progress = 0.0;
  final ExploreDomainController controller = Get.put(ExploreDomainController());

  @override
  void initState() {
    super.initState();
    // Fetch categories when the widget is initialized
    controller.getCategoryDat();
    controller.getCurrentLocationDetails();
  }

  void _updateProgress(double value) {
    setState(() {
      _progress = value;
      // Update the maxdistence value in the controller to reflect the new slider value
      controller.maxdistence.value =
          (_progress * 100).toStringAsFixed(0); // Convert to km
      controller.update();
    });
  }

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 60, left: 20, right: 20),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 64),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 50),
                Text(
                  "Filters",
                  style: GoogleFonts.fredoka(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff000000),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context); // Close the bottom sheet
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 36),
                    child: Text(
                      "Clear",
                      style: GoogleFonts.fredoka(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff32B768),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Flexible(fit: FlexFit.tight, child: CategoriesView()),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => Text(controller.locationName.value.isNotEmpty
                  ? controller.locationName.value // Display location name
                  : 'Location')),
              Padding(
                padding: const EdgeInsets.only(top: 34.0, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Distance",
                      style: GoogleFonts.roboto(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff000000),
                      ),
                    ),
                    Obx(() => Text(
                          "${controller.maxdistence.value}km", // Display selected km distance
                          style: GoogleFonts.roboto(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff000000),
                          ),
                        )),
                  ],
                ),
              ),
              Slider(
                inactiveColor: const Color(0xFFE8E6EA),
                activeColor: const Color(0xff32B768),
                value: _progress,
                onChanged: _updateProgress,
                min: 0.0,
                max: 1.0,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              controller.fillterdomin();
              Navigator.pop(context); // Close the bottom sheet
            },
            child: Container(
              margin: const EdgeInsets.only(top: 34),
              alignment: Alignment.center,
              height: 56,
              width: 306,
              decoration: BoxDecoration(
                color: const Color(0xff32B768),
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: const Color(0xff32B768),
                  width: 1.0,
                ),
              ),
              child: Text(
                "Continue",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
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

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  final Set<int> _selectedIndices = <int>{}; // Tracks selected categories
  final ExploreDomainController controller = Get.put(ExploreDomainController());

  @override
  void initState() {
    super.initState();
    // Fetch categories when the widget is initialized
    controller.getCategoryDat();
  }

  void _onItemTapped(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
        controller.categroyid.value =
            controller.categoryModel?.categoryList?[index].sId ??
                ''; // Set selected category ID
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(
            child: CircularProgressIndicator()); // Show loader while fetching
      }

      if (controller.categoryModel == null) {
        return const Center(child: Text('No categories available.'));
      }

      return Padding(
        padding: const EdgeInsets.only(bottom: 34.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 2.5,
          ),
          itemCount: controller.categoryModel!.categoryList!.length,
          itemBuilder: (context, index) {
            final bool isSelected = _selectedIndices.contains(index);
            final category = controller.categoryModel!.categoryList![index];

            return GestureDetector(
              onTap: () => _onItemTapped(index),
              child: Container(
                alignment: Alignment.center,
                height: 15,
                width: 61,
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xff32B768) : Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: isSelected ? const Color(0xff32B768) : Colors.grey,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  category.categoryName ?? 'Unknown',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xffFFFFFF),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
