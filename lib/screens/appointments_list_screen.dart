import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';
import 'package:mohammed_ashraf/screens/filter_screen_doc.dart';
import 'package:mohammed_ashraf/screens/search_screen_doc.dart';
import 'package:mohammed_ashraf/widgets/patient_card.dart';
import 'package:mohammed_ashraf/screens/search_screen.dart';
import 'package:mohammed_ashraf/screens/filter_screen.dart';
import 'package:mohammed_ashraf/screens/appointment_detail_screen.dart';

class AppointmentsListScreen extends StatelessWidget {
  const AppointmentsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> appointments = [
      {
        "imageUrl": 'assets/images/patient1.png',
        "name": 'Mohamed Ahmed',
        "status": 'Patient',
        "time": '10:30am - 11:00am',
      },
      {
        "imageUrl": 'assets/images/patient2.png',
        "name": 'Omar Ali',
        "status": 'Patient',
        "time": '12:00pm - 12:30pm',
      },
      {
        "imageUrl": 'assets/images/patient1.png', // Reused for example
        "name": 'Mohamed Ahmed',
        "status": 'Patient',
        "time": '02:30pm - 03:00pm',
      },
      {
        "imageUrl": 'assets/images/patient2.png', // Reused for example
        "name": 'Omar Ali',
        "status": 'Patient',
        "time": '04:00pm - 04:30pm',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments', style: TextStyle(color: AppColors.textColor)), // يمكنك تغيير لون العنوان إذا أردت
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.5,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreenDoctor()));
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search...',
                          prefixIcon: const Icon(
                            Icons.search,
                            color: AppColors.primaryColor,
                          ),
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0),
                            borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical:15.0, horizontal: 15.0),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FilterScreenDoctor()),
                    );
                  },
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                    padding: const EdgeInsets.all(13.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.filter_list, color: AppColors.textColor),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];
                return PatientCard(
                  imageUrl: appointment['imageUrl']!,
                  name: appointment['name']!,
                  status: appointment['status']!,
                  time: appointment['time']!,
                  onViewDetails: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AppointmentDetailScreen(patientName: appointment['name']!, patientImageUrl: appointment['imageUrl']!)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}