import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/screens/doctor_appointement.dart';
import 'package:mohammed_ashraf/screens/doctor_home.dart';
import 'package:mohammed_ashraf/screens/home_screen.dart';
import 'package:mohammed_ashraf/screens/main_screen.dart';
import 'package:mohammed_ashraf/screens/main_screen_doc.dart';
import 'package:provider/provider.dart'; // 👈 import provider
import 'package:mohammed_ashraf/features/splash_view.dart';
import 'package:mohammed_ashraf/features/auth/role_provider.dart';

import 'features/auth/add_photo.dart';
import 'features/auth/phone_number_verified.dart'; // 👈 import your provider

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => RoleProvider(), // 👈 inject RoleProvider
      child: const NeuroGuardApp(),
    ),
  );
}

class NeuroGuardApp extends StatelessWidget {
  const NeuroGuardApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreenDoctor(),
    );
  }
}
