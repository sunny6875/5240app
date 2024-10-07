import 'package:flutter/material.dart';
import 'package:project_5240_frontend/config/themes/app_color.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'New Message',
      'description': 'You have received a new message from John.',
      'time': '5 min ago',
    },
    {
      'title': 'Order Shipped',
      'description': 'Your order #12345 has been shipped!',
      'time': '1 hour ago',
    },
    {
      'title': 'Promotion',
      'description': '50% off on all items for today only!',
      'time': '2 hours ago',
    },
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        // backgroundColor: Colors.green,
      ),
      body: notifications.isNotEmpty
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  color: AppColors.white,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    selected: false, // Set this based on your logic
                    splashColor: Colors.white, // Remove splash effect
                    hoverColor: Colors.white, // Remove hover color
                    leading: const Icon(
                      Icons.notifications,
                      color: Colors.green,
                    ),
                    title: Text(notification['title'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification['description']),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            MaterialButton(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Approve",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 20),
                            MaterialButton(
                              height: 40,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                  color: AppColors.green,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Text(
                                "Cancel",
                                style: TextStyle(
                                  color: AppColors.green,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              onPressed: () {},
                            ),
                          ],
                        )
                      ],
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                          ),
                        ),
                        Text(
                          notification['time'],
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 10),
                        ),
                      ],
                    ),
                    onTap: null,
                  ),
                );
              },
            )
          : const Center(
              child: Text('No notifications'),
            ),
    );
  }
}
