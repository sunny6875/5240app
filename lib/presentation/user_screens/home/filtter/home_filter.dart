import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../explore_domain/controller/explore_domin_controller.dart';
import '../explore_domain/explore_domain_screen.dart';

class HomeFilterBottomSheet extends StatefulWidget {
  const HomeFilterBottomSheet({super.key});

  @override
  State<HomeFilterBottomSheet> createState() => _HomeFilterBottomSheetState();
}

class _HomeFilterBottomSheetState extends State<HomeFilterBottomSheet> {
  // Initialize the controller
  final ExploreDomainController _controller = Get.put(ExploreDomainController());

  // Selected sorting option
  String? _selectedSortOption = 'Most Viewed'; // Default selected option

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 60, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Adjusts to content size
        children: [
          // Sort By Text
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                "Sort by",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ),

          // Sort Options - Most Viewed
          _buildRadioOption(
            label: 'Most Viewed',
            value: 'Most Viewed',
            onTap: () async {
              await _controller.mostviewfetchDomains();
              print('most Fetched Domains: ${_controller.domainList}');
            },
          ),

          // Sort Options - Distance
          _buildRadioOption(
            label: 'Distance',
            value: 'Distance',
            onTap: () async {
              await _controller.distencefetchDomains();
              print('distence Fetched Domains: ${_controller.domainList}');
            },
          ),

          const SizedBox(height: 20),

          // Reset and Confirm Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildButton("Reset", Colors.white, const Color(0xff32B768), () {
                setState(() {
                  _selectedSortOption = 'Most Viewed'; // Reset to default
                  Get.back(); // Close the bottom sheet
                });
              }),
              _buildButton("Confirm", const Color(0xff32B768), Colors.white, () {
                Get.to(const ExploreDomainScreen());
                // Handle confirmation logic here
              }),
            ],
          ),
        ],
      ),
    );
  }

  // Helper function to build radio button options
  Widget _buildRadioOption({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSortOption = value; // Update the selected option
        });
        onTap(); // Trigger the onTap logic (API call)
      },
      child: Row(
        children: [
          Radio<String>(
            value: value,
            groupValue: _selectedSortOption, // Group radio buttons by selected value
            onChanged: (String? newValue) {
              setState(() {
                _selectedSortOption = newValue;
              });
              onTap(); // Trigger API call when option is selected
            },
            activeColor: const Color(0xff32B768),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // Helper function to build buttons
  Widget _buildButton(String text, Color bgColor, Color textColor, VoidCallback onPressed) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          height: 48,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: const Color(0xff32B768),
              width: 1.0,
            ),
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
