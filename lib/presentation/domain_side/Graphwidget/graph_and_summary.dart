import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/graph_controller.dart'; // Import GetX

class GraphAndSummary extends StatelessWidget {
  GraphAndSummary({super.key});

  final StockController stockController = Get.put(StockController());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double containerWidth = (screenWidth - 48) / 2; // Total horizontal padding (16 + 16) subtracted from screen width

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
      child: Obx(() {
        if (stockController.errorMessage.value != null) {
          return Center(child: Text(stockController.errorMessage.value!));
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                width: containerWidth,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '05',
                      style: TextStyle(
                        fontSize: screenWidth * 0.07, // Dynamic font size
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total Tracking',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04, // Dynamic font size
                        color: Colors.grey, // Use grey color
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                width: containerWidth,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() {
                      return Text(
                        stockController.totalViews.toString(),
                        style: TextStyle(
                          fontSize: screenWidth * 0.07, // Dynamic font size
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      );
                    }),
                    const SizedBox(height: 8),
                    Text(
                      'Total Views',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey, // Use grey color
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
