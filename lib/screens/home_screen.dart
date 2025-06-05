import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';
import 'package:mohammed_ashraf/screens/doctors_screen.dart';
import 'package:mohammed_ashraf/screens/notification_screen.dart';

import '../widgets/doctor_list.dart';
import '../widgets/promo_card.dart';
import '../widgets/search.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false, // Remove the back arrow
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'),
            ),
            SizedBox(width: 10),
            Text(
              'Mohamed Ali',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.grey,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationScreen()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Search(),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: PromoCard(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Find Doctors',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorsScreen()),
                      );
                    },
                    child: Text(
                      'See all',
                      style: TextStyle(fontSize: 14, color: MyColors.mainColor),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            DoctorList(),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
