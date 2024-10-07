import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';
import 'package:project_5240_frontend/data/models/provider_side_model/basic_item_model.dart';

class BasicItemCard extends StatelessWidget {
  final int index;
  final List<BasicItems>? basicItems;
  final void Function()? onTap;
  final bool isActive;
  const BasicItemCard(
    this.index, {
    super.key,
    this.basicItems,
    this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage:
                  CachedNetworkImageProvider(basicItems?[index].icon ?? ""),
            ),
            Text(
              basicItems?[index].name ?? "",
              style: TextStyle(
                fontFamily: "inter",
                fontSize: 14,
                color: isActive ? AppColors.green : Colors.black,
                fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
              ),
            )
          ],
        ),
      ),
    );
  }
}
