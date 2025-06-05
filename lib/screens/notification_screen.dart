import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';
import 'package:mohammed_ashraf/screens/main_screen.dart';
import 'package:mohammed_ashraf/widgets/no_notifications.dart';
import 'package:mohammed_ashraf/widgets/notifications.dart';



class NotificationScreen extends StatelessWidget {

  final List<Map<String, dynamic>> notifications = [
    {
      'title': 'Appointment Success',
      'message': 'You have successfully booked your appointment with Dr. Mohamed Ahmed',
      'time': '1h',
      'icon': Icons.calendar_today,
      'color': Colors.red
    },
    {
      'title': 'Appointment Success',
      'message': 'You have successfully booked your appointment with Dr. Mohamed Ahmed',
      'time': '2h',
      'icon': Icons.calendar_today,
      'color': Colors.blueAccent
    },
  ];

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(),
                            ),
                          );
          },
        ),
        title: Center(child: Text(
            'Notifications', style: TextStyle(color: Colors.black))),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: MyColors.mainColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              '1 New',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          )
        ],
      ),
      body: notifications.isNotEmpty ?
          Notifications(notifications: notifications) : NoNotifications()
    );
  }
}


