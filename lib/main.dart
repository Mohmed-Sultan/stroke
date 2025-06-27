import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/features/auth/providers/patient_appointment_filteration_provider.dart';
import 'package:mohammed_ashraf/screens/doctor_appointement.dart';
import 'package:mohammed_ashraf/screens/doctor_home.dart';
import 'package:mohammed_ashraf/screens/home_screen.dart';
import 'package:mohammed_ashraf/screens/main_screen.dart';
import 'package:mohammed_ashraf/screens/main_screen_doc.dart';
import 'package:provider/provider.dart'; // 👈 import provider
import 'package:mohammed_ashraf/features/splash_view.dart';
import 'package:mohammed_ashraf/features/auth/role_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/app_colors.dart';
import 'core/dio/dio_client.dart';
import 'core/providers/setting_provider.dart';
import 'features/auth/add_photo.dart';
import 'features/auth/login.dart';
import 'features/auth/phone_number_verified.dart';
import 'features/auth/providers/register_provider.dart'; // 👈 import your provider

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Dio client
  final dioClient = DioClient();
  await dioClient.initCookieManager();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RoleProvider(dioClient)),
        ChangeNotifierProvider(create: (_) => SettingsViewModel()),
        ChangeNotifierProvider(create: (_) => PatientAppointmentFilterationProvider()),
        ChangeNotifierProvider(create: (_) => RegistrationProvider()),
      ],
      child: NeuroGuardApp(dioClient: dioClient),
    ),
  );
}


class NeuroGuardApp extends StatelessWidget {
  const NeuroGuardApp({super.key, required this.dioClient});
  final DioClient dioClient;

  @override
  Widget build(BuildContext context) {
   return Consumer<SettingsViewModel>(
        builder: (context, settings, child) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: AppTheme.getTheme( ThemeMode.light),
      darkTheme: AppTheme.getTheme( ThemeMode.dark),
      themeMode: settings.themeMode,
      home: FutureBuilder(
        future: context.read<RoleProvider>().autoLogin(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final provider = context.watch<RoleProvider>();

            if (provider.user != null) {
              return provider.user!.role == 'Patient'
                  ? MainScreen()
                  : MainScreenDoctor();
            }
            return   LoginScreen();
          }
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );});
  }
}
