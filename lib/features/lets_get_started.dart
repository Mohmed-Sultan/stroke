import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/features/auth/login.dart';
import 'package:mohammed_ashraf/features/auth/register1.dart';
import 'package:mohammed_ashraf/features/auth/register2.dart'; // أضف هذه الصفحة للطبيب
import 'package:provider/provider.dart';

import 'auth/role_provider.dart';

class LetsGetStartedView extends StatelessWidget {
  const LetsGetStartedView({super.key});

  @override
  Widget build(BuildContext context) {
    // الحصول على الدور من الـ Provider
    final selectedRole = Provider.of<RoleProvider>(context).role;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/Logo.png'),
            const SizedBox(height: 20),
            const Text(
              "Let's Get Started!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            // عرض الدور المحدد
            // Text(
            //   "Your Role: $selectedRole",
            //   style: const TextStyle(
            //     fontSize: 18,
            //     color: Colors.teal,
            //     fontWeight: FontWeight.w600,
            //   ),
            // ),

            const SizedBox(height: 10),
            const Text(
              "Login to enjoy the features we have provided and be well!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),

            // زر تسجيل الدخول
            GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(27, 132, 153, 0.89),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // زر إنشاء حساب (Sign Up) مع التحقق من الدور
            GestureDetector(
              onTap: () {
                // التحقق من الدور والانتقال للصفحة المناسبة
                if (selectedRole == 'Patient') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistreScreenFirst(),
                    ),
                  );
                } else if (selectedRole == 'Doctor') {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistreScreenSecond(), // تأكد من وجود صفحة "RegistreScreenSecond" للطبيب
                    ),
                  );
                } else {
                  // يمكنك إضافة رسالة تنبيه هنا إذا لم يكن الدور محددًا
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Role not selected')),
                  );
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.teal,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
