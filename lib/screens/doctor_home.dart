import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';
import 'package:mohammed_ashraf/screens/doctor_notification_exists.dart';
import 'package:mohammed_ashraf/screens/doctor_search.dart';
import 'package:mohammed_ashraf/screens/filter_screen_doc.dart';
import 'package:mohammed_ashraf/screens/notifications_screen_Doc.dart';
import 'package:mohammed_ashraf/screens/search_screen_doc.dart';
import 'package:mohammed_ashraf/widgets/patient_card.dart';


class HomeDoctor extends StatelessWidget {
  const HomeDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Dr. Ahmed & Notification Bell
              Row(
                children: [
                  const CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage('assets/images/docimg.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    'Dr. Ahmed',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.notifications_none_outlined, size: 28, color: AppColors.textColor),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const NotificationsScreendoctor()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Search Bar and Filter Button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const SearchScreenDoctor()),
                          );
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
                              contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
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
                          MaterialPageRoute(builder: (context) =>FilterScreenDoctor()),
                        );
                      },
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        padding: const EdgeInsets.all(13.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: const Icon(Icons.filter_list, color: AppColors.textColor),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Banner
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Take Control Of Your Patients\' Health - Review Their Stroke Risk Predictions Now!',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: List.generate(4, (index) => Container(
                              margin: const EdgeInsets.only(right: 4),
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: index == 0 ? Colors.white : Colors.white.withOpacity(0.5),
                                shape: BoxShape.circle,
                              ),
                            )),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: Image.asset(
                        'assets/images/banner2.png',
                        height: 100,
                        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 50, color: Colors.white54),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Find Patients Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Find Patients',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textColor),
                  ),
                  TextButton(
                    onPressed: () {
                      final tabController = DefaultTabController.of(context);
                      if (tabController != null) {
                        tabController.animateTo(1);
                      } else {
                        print("TabController not found in HomeScreen. Cannot switch tab for 'See all'.");
                      }
                    },
                    child: const Text('See all', style: TextStyle(color: AppColors.primaryColor)),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              PatientCard(
                imageUrl: 'assets/images/patient1.png',
                name: 'Mohamed Ahmed',
                status: 'Patient',
                time: '10:30am - 11:00am',
                onViewDetails: () {
                },
              ),
              const SizedBox(height: 10),
              PatientCard(
                imageUrl: 'assets/images/patient2.png',
                name: 'Omar Ali',
                status: 'Patient',
                time: '12:00pm - 12:30pm',
                onViewDetails: () {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}