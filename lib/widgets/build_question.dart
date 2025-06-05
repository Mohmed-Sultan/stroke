import 'package:flutter/material.dart';

import '../core/core.dart';

class BuildQuestion extends StatefulWidget {
  const BuildQuestion({super.key, required this.index, required this.questions, required this.selectedAnswers});

  final int index;
  final List<Map<String, dynamic>> questions;
  final Map<int, dynamic> selectedAnswers;

  @override
  State<BuildQuestion> createState() => _BuildQuestionState();
}

class _BuildQuestionState extends State<BuildQuestion> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        Text(
          "Predict your stroke risk now!",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          "Answer the following questions to help us assess your risk of stroke",
          style: TextStyle(fontSize: 13, color: Colors.black54),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 40),
        Center(
          child: Text(
            "Step ${widget.index + 1} of ${widget.questions.length}",
            style: TextStyle(
                color: MyColors.mainColor, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 20),
        Text(
          widget.questions[widget.index]['question'],
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        Column(
          children: (widget.questions[widget.index]['options'] as List<String>).map((
              option) {
            return RadioListTile(
              title: Text(option),
              value: option,
              groupValue: widget.selectedAnswers[widget.index],
              onChanged: (value) {
                setState(() {
                  widget.selectedAnswers[widget.index] = value;
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
