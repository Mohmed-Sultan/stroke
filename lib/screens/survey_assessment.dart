import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';
import 'assessment_result.dart';

class StrokeRiskAssessment extends StatefulWidget {
  const StrokeRiskAssessment({super.key});

  @override
  _StrokeRiskAssessmentState createState() => _StrokeRiskAssessmentState();
}

class _StrokeRiskAssessmentState extends State<StrokeRiskAssessment> {
  final PageController _pageController = PageController();
  final _formKey = GlobalKey<FormState>();

  int _currentIndex = 0;

  // Variables to hold user input
  String? gender;
  String? age;
  int? hypertension;
  int? heartDisease;
  String? everMarried;
  String? workType;
  String? residenceType;
  String? avgGlucose;
  String? bmi;
  String? smokingStatus;
  int? stroke;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextQuestion() {
    // Validate text fields before proceeding
    if (_isTextStep(_currentIndex) && !_formKey.currentState!.validate()) return;
    if (_isTextStep(_currentIndex)) _formKey.currentState!.save();

    if (_currentIndex < 10) {
      setState(() => _currentIndex++);
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Submit logic or navigate to results
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AssessmentResult()),
      );
    }
  }

  void _previousQuestion() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  bool _isTextStep(int index) {
    return index == 1 || index == 7 || index == 8; // age, glucose, BMI
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title and Description
            Center(
              child: Column(
                children: const [
                  Text(
                    "Predict your stroke risk now!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Answer the following questions to help us\nassess your risk of stroke",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                      height: 1.4,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // PageView content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildRadioQuestion(
                      'What is your gender?',
                      ['Male', 'Female'],
                      (val) => setState(() => gender = val),
                      gender),
                  _buildTextQuestion(
                      'How old are you?',
                      (val) => age = val,
                      age,
                      TextInputType.number),
                  _buildRadioQuestion(
                      'Do you have hypertension?',
                      ['Yes', 'No'],
                      (val) => setState(() => hypertension = val == 'Yes' ? 1 : 0),
                      hypertension == null ? null : (hypertension == 1 ? 'Yes' : 'No')),
                  _buildRadioQuestion(
                      'Do you have heart disease?',
                      ['Yes', 'No'],
                      (val) => setState(() => heartDisease = val == 'Yes' ? 1 : 0),
                      heartDisease == null ? null : (heartDisease == 1 ? 'Yes' : 'No')),
                  _buildRadioQuestion(
                      'Have you ever been married?',
                      ['Yes', 'No'],
                      (val) => setState(() => everMarried = val),
                      everMarried),
                  _buildRadioQuestion(
                      'What is your work type?',
                      ['Children', 'Govt job', 'Never worked', 'Private', 'Self employed'],
                      (val) => setState(() => workType = val),
                      workType),
                  _buildRadioQuestion(
                      'What is your residence type?',
                      ['Rural', 'Urban'],
                      (val) => setState(() => residenceType = val),
                      residenceType),
                  _buildTextQuestion(
                      'What is your average glucose level?',
                      (val) => avgGlucose = val,
                      avgGlucose,
                      TextInputType.number),
                  _buildTextQuestion(
                      'What is your BMI?',
                      (val) => bmi = val,
                      bmi,
                      TextInputType.number),
                  _buildRadioQuestion(
                      'What is your smoking status?',
                      ['Formerly smoked', 'Never smoked', 'Smokes', "Won't answer"],
                      (val) => setState(() => smokingStatus = val == "Won't answer" ? 'Unknown' : val),
                      smokingStatus == 'Unknown' ? "Won't answer" : smokingStatus),
                  _buildRadioQuestion(
                      'Have you ever had a stroke?',
                      ['Yes', 'No'],
                      (val) => setState(() => stroke = val == 'Yes' ? 1 : 0),
                      stroke == null ? null : (stroke == 1 ? 'Yes' : 'No')),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Navigation Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentIndex > 0)
                  SizedBox(
                    width: 120,
                    child: OutlinedButton(
                      onPressed: _previousQuestion,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: MyColors.mainColor,
                        side: BorderSide(color: MyColors.mainColor),
                      ),
                      child: const Text("Back"),
                    ),
                  ),
                SizedBox(
                  width: 120,
                  child: ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.mainColor,
                    ),
                    child: Text(
                      _currentIndex == 10 ? "Predict" : "Next",
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

  Widget _buildRadioQuestion(
  String question,
  List<String> options,
  ValueChanged<String> onChanged,
  String? selected,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Text(
          'Step ${_currentIndex + 1} of 11', // <-- updated here
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyColors.mainColor,
          ),
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            ...options.map((opt) => RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(opt, style: TextStyle(fontSize: 16)),
                  value: opt,
                  groupValue: selected,
                  activeColor: MyColors.mainColor,
                  onChanged: (val) => onChanged(val!),
                )),
          ],
        ),
      ),
    ],
  );
}



  Widget _buildTextQuestion(
  String question,
  FormFieldSetter<String> onSaved,
  String? initialValue,
  TextInputType keyboardType,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Center(
        child: Text(
          'Step ${_currentIndex + 1} of 11', // <-- updated here
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: MyColors.mainColor,
          ),
        ),
      ),
      const SizedBox(height: 20),
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(question,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: initialValue,
              keyboardType: keyboardType,
              validator: (val) => val == null || val.isEmpty ? 'Required' : null,
              onSaved: onSaved,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

}
