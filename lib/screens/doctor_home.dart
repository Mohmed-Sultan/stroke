import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';
import 'package:mohammed_ashraf/screens/filter_screen_doc.dart';
import 'package:mohammed_ashraf/screens/notifications_screen_Doc.dart';
import 'package:mohammed_ashraf/screens/search_screen_doc.dart';
import 'package:mohammed_ashraf/widgets/patient_card.dart';

import '../features/auth/models/user_model.dart';
import '../features/auth/role_provider.dart';

class HomeDoctor extends StatefulWidget {
  const HomeDoctor({super.key});

  @override
  State<HomeDoctor> createState() => _HomeDoctorState();
}

class _HomeDoctorState extends State<HomeDoctor> {
  List<Patient> patients = [];
  bool isLoading = true;
  String? errorMessage;
  int page = 1;
  final int limit = 10;

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final roleProvider = Provider.of<RoleProvider>(context, listen: false);
      final response = await roleProvider.dioClient.getPatients(
        // gender: 'Female',
        // page: page,
        // limit: limit,
      );

      if (response['status'] == 'success') {
        final List<dynamic> patientData = response['data'];
        print(patientData);
        setState(() {
          patients = patientData.map((json) => Patient.fromJson(json)).toList();
        });
      } else {
        setState(() {
          errorMessage = response['message'] ?? 'Failed to fetch patients';

          // Handle specific errors
          if (response['code'] == 401) {
            errorMessage = 'Session expired. Please login again.';
            // Optionally trigger logout
            // roleProvider.logout(context);
          }
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() => isLoading = false);
    }
  }

  void _nextPage() {
    setState(() => page++);
    _fetchPatients();
  }

  void _prevPage() {
    if (page > 1) {
      setState(() => page--);
      _fetchPatients();
    }
  }

  @override
  Widget build(BuildContext context) {
    final roleProvider = Provider.of<RoleProvider>(context);
    final doctorName = roleProvider.user?.firstName ?? 'Doctor';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Doctor's Name & Notification Bell
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundImage: roleProvider.user?.profileImg != null
                        ? NetworkImage(roleProvider.user!.profileImg) as ImageProvider
                        : const AssetImage('assets/images/docimg.png'),
                    backgroundColor: Colors.transparent,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Dr. $doctorName',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor),
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

              // // Search Bar and Filter Button
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 0.0),
              //   child: Row(
              //     children: [
              //       Expanded(
              //         child: GestureDetector(
              //           onTap: () {
              //             Navigator.push(
              //               context,
              //               MaterialPageRoute(builder: (context) => const SearchScreenDoctor()),
              //             );
              //           },
              //           child: AbsorbPointer(
              //             child: TextField(
              //               decoration: InputDecoration(
              //                 hintText: 'Search...',
              //                 prefixIcon: const Icon(
              //                   Icons.search,
              //                   color: AppColors.primaryColor,
              //                 ),
              //                 filled: true,
              //                 fillColor: Colors.grey[100],
              //                 border: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(12.0),
              //                   borderSide: BorderSide.none,
              //                 ),
              //                 focusedBorder: OutlineInputBorder(
              //                   borderRadius: BorderRadius.circular(12.0),
              //                   borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
              //                 ),
              //                 contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       InkWell(
              //         onTap: () {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(builder: (context) => FilterScreenDoctor()),
              //           );
              //         },
              //         borderRadius: BorderRadius.circular(12.0),
              //         child: Container(
              //           padding: const EdgeInsets.all(13.0),
              //           decoration: BoxDecoration(
              //             color: Colors.grey[100],
              //             borderRadius: BorderRadius.circular(12.0),
              //           ),
              //           child: const Icon(Icons.filter_list, color: AppColors.textColor),
              //         ),
              //       )
              //     ],
              //   ),
              // ),
              // const SizedBox(height: 20),

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
                  // TextButton(
                  //   onPressed: () {
                  //     // Show all patients - implement if needed
                  //   },
                  //   child: const Text('See all', style: TextStyle(color: AppColors.primaryColor)),
                  // ),
                ],
              ),
              const SizedBox(height: 10),

              // Loading state
              if (isLoading)
                const Center(child: CircularProgressIndicator()),

              // Error state
              if (errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),

              // Patient list
              if (!isLoading && errorMessage == null && patients.isNotEmpty)
                Column(
                  children: [
                    ...patients.map((patient) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: PatientCard(
                        imageUrl: 'assets/images/patient1.png', // Default image
                        name: '${patient.firstName} ${patient.lastName}',
                        status: 'Patient',
                        time: '', // No time available from API
                        onViewDetails: () {
                          // Implement patient details navigation
                        },
                      ),
                    )).toList(),

                    // Pagination controls
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (page > 1)
                            ElevatedButton(
                              onPressed: _prevPage,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primaryColor,
                              ),
                              child: const Text('Previous'),
                            ),
                          // if (page > 1) const SizedBox(width: 20),
                          // Text('Page $page'),
                          // const SizedBox(width: 20),
                          // ElevatedButton(
                          //   onPressed: _nextPage,
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: AppColors.primaryColor,
                          //   ),
                          //   child: const Text('Next'),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),

              // Empty state
              if (!isLoading && errorMessage == null && patients.isEmpty)
                const Center(
                  child: Text(
                    'No patients found',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}