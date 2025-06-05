import 'package:flutter/material.dart';

import 'doctor_card.dart';

class DoctorList extends StatelessWidget {
  final List<Map<String, String>> doctors = [
    {
      'name': 'Dr. Mohamed Ahmed',
      'specialty': 'Neurologist | Mercy Hospital',
      'rating': '4.8',
      'time': '10:30am - 5:30pm'
    },
    {
      'name': 'Dr. Omar Ali',
      'specialty': 'Neurologist | ABC Hospital',
      'rating': '4.8',
      'time': '10:30am - 5:30pm'
    },
  ];

  DoctorList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: doctors.map((doctor) => DoctorCard(doctor: doctor,)).toList(),
    );
  }
}