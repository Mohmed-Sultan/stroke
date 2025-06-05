import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/screens/main_screen.dart';
import '../widgets/doctor_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  // Sample data for favorite doctors
  static const List<Map<String, String>> favouriteDoctors = [
    {
      'name': 'Mohamed Ahmed',
      'specialty': 'Neurologist',
      'hospital': 'Mercy Hospital',
      'rating': '4.8',
      'time': '10:30am - 5:30pm',
    },
    {
      'name': 'Omar Ali',
      'specialty': 'Neurologist',
      'hospital': 'ABC hospital',
      'rating': '4.8',
      'time': '10:30am - 5:30pm',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Favorites'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         decoration: InputDecoration(
            //           hintText: 'Search...',
            //           prefixIcon: Icon(Icons.search, color: MyColors.mainColor),
            //           border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(12),
            //           ),
            //         ),
            //       ),
            //     ),
            //     const SizedBox(width: 12),
            //     Container(
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(12),
            //         border: Border.all(color: Colors.grey.shade300),
            //       ),
            //       child: IconButton(
            //         icon: Icon(Icons.filter_list, color: MyColors.mainColor),
            //         onPressed: () {},
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: favouriteDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = favouriteDoctors[index];
                  return DoctorCard(
                    doctor: doctor,
                    isInitiallyFavorite: true, // Add this parameter to your DoctorCard
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}