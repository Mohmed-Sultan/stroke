import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';
import 'package:mohammed_ashraf/screens/profile_screen.dart';
import 'package:mohammed_ashraf/screens/scan_screen.dart';
import 'chatbot_screen.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    FavoriteScreen(),
    ScanScreen(),
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
            icon: Icon(Icons.favorite_outline),
            label: 'Favorite',
            tooltip: 'Your Favorites', // Optional tooltip
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
            tooltip: 'Scan QR Codes', // Optional tooltip
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
