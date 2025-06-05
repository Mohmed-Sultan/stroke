import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';
import 'package:mohammed_ashraf/screens/payment_screen.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  int? selectedTime;
  int? selectedDate;

  final List<String> times = ['10.00 AM', '11.00 AM', '12.00 PM'];
  final List<String> dates = ['Sun 4', 'Mon 5', 'Tue 6'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Appointment', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('assets/images/docimg.png'),
                ),
                SizedBox(width: 26),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Dr. Alaa', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('Neurologist', style: TextStyle(color: MyColors.mainColor)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Payment', style: TextStyle(fontWeight: FontWeight.bold)),
                        SizedBox(width: 18),
                        Text('\$120.00', style: TextStyle(color: MyColors.mainColor)),
                      ],
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Details', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text('4.8'),
                    SizedBox(width: 3,),
                    Icon(Icons.star, color: Colors.yellow,),
                  ],
                )
              ],
            ),
            SizedBox(height: 8),
            Text(
              'Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.',
              style: TextStyle(color: Colors.grey,fontSize: 16),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Working Hours', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('see all', style: TextStyle(color: MyColors.mainColor),)
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: times.asMap().entries.map((entry) => ChoiceChip(
                selectedColor: MyColors.mainColor,
                backgroundColor: MyColors.thirdColor,
                label: Text(entry.value),
                selected: selectedTime == entry.key,
                onSelected: (bool selected) {
                  setState(() {
                    selectedTime = selected ? entry.key : null;
                  });
                },
              )).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('see all', style: TextStyle(color: MyColors.mainColor),)
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: dates.asMap().entries.map((entry) => ChoiceChip(
                selectedColor: MyColors.mainColor,
                backgroundColor: MyColors.thirdColor,
                label: Text(entry.value),
                selected: selectedDate == entry.key,
                onSelected: (bool selected) {
                  setState(() {
                    selectedDate = selected ? entry.key : null;
                  });
                },
              )).toList(),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyColors.mainColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)
                  => PaymentScreen()));
                },
                child: Text('Book Appointment', style: TextStyle(
                    fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

