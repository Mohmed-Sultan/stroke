import 'package:flutter/material.dart';

import 'notification_card.dart';

class Notifications extends StatelessWidget {

   const Notifications({super.key, required this.notifications});
   final List<Map<String, dynamic>> notifications;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'TODAY',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return NotificationCard(notification: notification);
              },
            ),
          ),
        ],
      ),
    );
  }
}
