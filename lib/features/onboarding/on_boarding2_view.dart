import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/features/auth/select_your_role.dart';

class OnboardingViewSecond extends StatelessWidget {
  const OnboardingViewSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/calendar.png',
                    height: 450,
                  ),
                ),
              ),
              const Text(
                "Mark Your Schedule\nAccording To Your Calendar",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Lorem ipsum dolor sit amet consectetur.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RoleSelectionScreen(), // Replace with your next screen
        ),
      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:  const Color.fromRGBO(27, 132, 153, 0.89),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                   Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RoleSelectionScreen(), // Replace with your next screen
        ),
      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(color: Colors.teal),
                  ),
                ),
                child: const Text(
                  "Skip",
                  style: TextStyle(fontSize: 16, color: Colors.teal),
                ),
              ),
              const SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 4, backgroundColor: Colors.grey),
                  SizedBox(width: 8),
                  CircleAvatar(radius: 4, backgroundColor: Colors.teal),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
