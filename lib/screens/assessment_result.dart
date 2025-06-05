import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/screens/main_screen.dart';
import 'package:mohammed_ashraf/widgets/bad_result.dart';
import 'package:mohammed_ashraf/widgets/good_result.dart';

import '../core/core.dart';

class AssessmentResult extends StatelessWidget {
  const AssessmentResult({super.key});

  @override
  Widget build(BuildContext context) {

    final double probability = 60;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Text('Prediction Results', style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold
            ),),
            SizedBox(height: 15,),
            probability < 50 ?
            GoodResult(probability: probability,) : BadResult(probability: probability,),
            SizedBox(height: 45,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.mainColor,
                minimumSize: Size(double.infinity, 45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => MainScreen()));
              },
              child: Text(
                'Continue to Home',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
