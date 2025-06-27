import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/constants/app_colors.dart';
import 'package:mohammed_ashraf/screens/patient_report_screen.dart';
import 'package:mohammed_ashraf/widgets/custom_filter_chip.dart';

class AppointmentDetailScreen extends StatefulWidget {
  final String patientName;
  final String patientImageUrl;

  const AppointmentDetailScreen({
    super.key,
    required this.patientName,
    required this.patientImageUrl,
  });

  @override
  State<AppointmentDetailScreen> createState() => _AppointmentDetailScreenState();
}

class _AppointmentDetailScreenState extends State<AppointmentDetailScreen> {
  String _selectedTime = "11.00 AM";
  String _selectedDate = "Sun 4";

  final List<String> _timeSlots = ["10.00 AM", "11.00 AM", "12.00 PM"];
  final List<String> _dateSlots = ["Sun 4", "Mon 5", "Tue 6"];

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textColor),
      ),
    );
  }

  Widget _buildSelectableList(List<String> items, String selectedItem, ValueChanged<String> onItemSelected) {
    return SizedBox(
      height: 45,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          return CustomFilterChip(
            label: items[index],
            isSelected: selectedItem == items[index],
            onSelected: () => onItemSelected(items[index]),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            borderRadius: 8.0,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textColor),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Appointment', style: TextStyle(color: AppColors.textColor, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        elevation: 0.5,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    widget.patientImageUrl,
                    width: 90,
                    height: 110,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      width: 90,
                      height: 110,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.person, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.patientName,
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textColor), // تعديل حجم الخط
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Patient',
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]), // تعديل حجم الخط
                      ),
                    ],
                  ),
                ),
              ],
            ),
            _buildSectionTitle('Details'),
            Text(
              'Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna et lacus.',
              style: TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.55), // تعديل ارتفاع السطر
            ),

            _buildSectionTitle('Appointment'),
            _buildSelectableList(_timeSlots, _selectedTime, (val) => setState(() => _selectedTime = val)),
            const SizedBox(height: 16),

            _buildSectionTitle('Date'),
            _buildSelectableList(_dateSlots, _selectedDate, (val) => setState(() => _selectedDate = val)),
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0, top: 10.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => PatientReportScreen(patientId: widget.patientName)));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          child: const Text('View Patient\'s Report'),
        ),
      ),
    );
  }
}