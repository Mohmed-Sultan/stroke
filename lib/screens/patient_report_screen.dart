import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';
import 'package:mohammed_ashraf/features/auth/models/appointment_model.dart';
import 'package:mohammed_ashraf/features/auth/models/user_model.dart';

import '../core/dio/dio_client.dart';

class PatientReportScreen extends StatefulWidget {
  final String patientId;

  const PatientReportScreen({super.key, required this.patientId});

  @override
  State<PatientReportScreen> createState() => _PatientReportScreenState();
}

class _PatientReportScreenState extends State<PatientReportScreen> {
  Widget _buildSectionHeader(String title, BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      margin: const EdgeInsets.only(top: 16.0, bottom: 16.0),
      decoration: BoxDecoration(
        color: AppColors.lightBlue.withOpacity(0.7),
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 15, color: Colors.grey[700])),
          Text(value,
              style:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
  String _formatDate(DateTime time) {
    return DateFormat('MMM dd, yyyy').format(time);
  }
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      patient = await _fetchSinglePatient();
      setState(() {});
    });
    super.initState();
  }
bool isLoading=true;
  final DioClient _dioClient = DioClient();
  Patient? patient;
  Future<Patient> _fetchSinglePatient() async {
    setState(() {
      isLoading=true;
    });
    try {
      final response = await _dioClient.getOnePatients(id: widget.patientId);

      final data = response['data'];
      //print(data);
      return Patient.fromJson((data));
    } catch (e) {
      throw Exception('Failed to load Patient data: $e');
    }finally{
      setState(() {
        isLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Patient\'s Report'),
        centerTitle: true,
        elevation: 0.5,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: patient != null
              ? [
                  _buildSectionHeader('Patient Details', context),
                  _buildDetailRow('Name:', patient!.firstName),
                  _buildDetailRow('Age:', _formatDate(patient!.dateOfBirth)),
                  _buildDetailRow('Gender:', patient!.gender),
                  _buildDetailRow('Phone No:', patient!.phone),
                  _buildDetailRow('Address:', patient!.address),
                  _buildDetailRow('Medical History:', 'No'),
                  const SizedBox(height: 10),
                  _buildSectionHeader('X-Rays', context),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/xray_1.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 150,
                                color: Colors.grey[300],
                                child: const Center(
                                    child: Text("X-Ray 1\nNot Found",
                                        textAlign: TextAlign.center)),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/xray_2.png',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                height: 150,
                                color: Colors.grey[300],
                                child: const Center(
                                    child: Text("X-Ray 2\nNot Found",
                                        textAlign: TextAlign.center)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildSectionHeader('Prediction', context),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 20.0),
                    child: Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(
                              fontSize: 17,
                              color: AppColors.textColor,
                              height: 1.4),
                          children: <TextSpan>[
                            TextSpan(
                                text: 'High Risk of stroke. Probability : '),
                            TextSpan(
                              text: '54.72%',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ]
              : [
                SizedBox(height: height*0.5,),
            isLoading==true?Center(child: CircularProgressIndicator()):
                Center(child: Text("Nothing to show"))],
        ),
      ),
    );
  }
}
