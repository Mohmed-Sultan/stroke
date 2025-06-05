import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;

  const NotificationCard({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: notification['color'].withOpacity(0.2),
          child: Icon(notification['icon'], color: notification['color']),
        ),
        title: Text(notification['title'], style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(notification['message']),
        trailing: Text(notification['time'], style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}