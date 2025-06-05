import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';
import 'package:mohammed_ashraf/screens/survey_assessment.dart';

class StartSurveyScreen extends StatelessWidget {
  const StartSurveyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Predict your stroke risk now!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Image.asset(
              'assets/images/stroke_risk_image.png',
              height: 400,
            ),
            SizedBox(height: 20),
            Text(
              'Answer a few quick questions to help us assess your risk of stroke',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.mainColor,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => StrokeRiskAssessment()));
              },
              child: Text(
                'Start',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "By clicking 'Start' you agree to our Terms of Service & Privacy Policy.",
              style: TextStyle(fontSize: 14, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
