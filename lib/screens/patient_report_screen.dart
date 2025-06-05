import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';

class PatientReportScreen extends StatelessWidget {
  final String patientName;
  const PatientReportScreen({super.key, required this.patientName});

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
          Text(value, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Patient Details', context),
            _buildDetailRow('Name:', patientName),
            _buildDetailRow('Age:', '32 years'),
            _buildDetailRow('Gender:', 'Male'),
            _buildDetailRow('Phone No:', '7500190739'),
            _buildDetailRow('Address:', 'Lorem ipsum dolor sit'),
            _buildDetailRow('Medical History:', 'No'),
            const SizedBox(height: 10),

            _buildSectionHeader('X-Rays', context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.asset(
                        'assets/images/xray_1.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 150,
                          color: Colors.grey[300],
                          child: const Center(child: Text("X-Ray 1\nNot Found", textAlign: TextAlign.center)),
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
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 150,
                          color: Colors.grey[300],
                          child: const Center(child: Text("X-Ray 2\nNot Found", textAlign: TextAlign.center)),
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
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(fontSize: 17, color: AppColors.textColor, height: 1.4),
                    children: <TextSpan>[
                      TextSpan(text: 'High Risk of stroke. Probability : '),
                      TextSpan(
                        text: '54.72%',
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}