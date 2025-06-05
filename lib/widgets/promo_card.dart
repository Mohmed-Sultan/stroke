import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';
import 'package:mohammed_ashraf/screens/start_survey.dart';

class PromoCard extends StatelessWidget {
  const PromoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      height: 180,
      decoration: BoxDecoration(
        color: MyColors.mainColor, // <-- لون الخلفية فقط
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          // النص والزر
          Positioned(
            left: 16,
            top: 24,
            bottom: 24,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Take The First Step Towards A Healthier Future – Predict Your Stroke Risk Now!',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StartSurveyScreen(),
                        ),
                      );
                    },
                    child: Container(
                      height: 35,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Check Now',
                          style: TextStyle(
                            color: MyColors.mainColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // صورة الدكتور على الجانب الأيمن
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Image.asset(
              'assets/images/doc.png', // <-- ضع مسار صورة الدكتور هنا
              fit: BoxFit.contain,
              height: 160,
            ),
          ),
        ],
      ),
    );
  }
}
