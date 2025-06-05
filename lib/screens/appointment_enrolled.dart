import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';

class AppointmentEnrolledScreen extends StatelessWidget {
  final String amount = '\$50';

  const AppointmentEnrolledScreen({super.key}); // You can pass this dynamically

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Checkmark icon inside circle
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: MyColors.mainColor, width: 3),
                ),
                child: Icon(Icons.check, color: MyColors.mainColor, size: 50),
              ),
              SizedBox(height: 30),

              // Confirmation text
              Text(
                'Appointment enrolled',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),

              // Payment confirmation details
              Text.rich(
                TextSpan(
                  text: 'Your ',
                  style: TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: amount,
                      style: TextStyle(fontWeight: FontWeight.bold, color: MyColors.mainColor),
                    ),
                    TextSpan(
                      text: ' appointment payment has been successfully completed. Thank you for choosing us!',
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 100),

              // Back to Home button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Adjust to your home screen route
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.mainColor,
                    padding: EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text('Back to Home', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
