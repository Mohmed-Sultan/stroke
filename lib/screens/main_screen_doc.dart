import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';
import 'package:mohammed_ashraf/screens/appointment_detail_screen.dart';
import 'package:mohammed_ashraf/screens/appointments_list_screen.dart';
import 'package:mohammed_ashraf/screens/doctor_home.dart';
import 'package:mohammed_ashraf/screens/profile_screen.dart';
import 'package:mohammed_ashraf/screens/scan_screen.dart';
import 'chatbot_screen.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';

class MainScreenDoctor extends StatefulWidget {
  const MainScreenDoctor({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreenDoctor> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeDoctor(),
  AppointmentsListScreen(),
    ChatbotScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColors.secondColor,
        currentIndex: _selectedIndex,
        selectedItemColor: MyColors.mainColor,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.other_houses),
            label: 'Home',
            tooltip: 'Go to Home', // Optional tooltip
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.date_range_outlined),
            label: 'Appointments',
            tooltip: 'Your Appointments', // Optional tooltip
          ),
         
          BottomNavigationBarItem(
            icon: Icon(Icons.smart_toy_outlined),
            label: 'Chatbot',
            tooltip: 'Talk to Chatbot', // Optional tooltip
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_circle_outlined),
            label: 'Profile',
            tooltip: 'Your Profile', // Optional tooltip
          ),
        ],
      ),
    );
  }
}
