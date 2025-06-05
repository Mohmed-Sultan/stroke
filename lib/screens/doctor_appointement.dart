import 'package:flutter/material.dart';



// ~~~~~~~~~~~~~~~~~ AppointmentsScreen ~~~~~~~~~~~~~~~~~
class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: const Text('Appointments',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Search...',
                        prefixIcon: const Icon(Icons.search, color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(255, 245, 251, 255),
                        contentPadding: const EdgeInsets.symmetric(vertical: 10)
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 245, 251, 255),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child:  const Icon(Icons.filter_list_outlined, color: Color.fromARGB(255, 0, 148, 160),),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAppointmentCard(
                      context: context,
                      name: 'Mohamed Ahmed',
                      time: '10:30am - 11:0am',
                      image: 'assets/patient1.png'
                  ),
                  const SizedBox(height: 16),
                  _buildAppointmentCard(
                      context: context,
                      name: 'Omar Ali',
                      time: '12:00pm - 12:30pm',
                      image: 'assets/patient2.png'
                  ),
                  const SizedBox(height: 16),
                  _buildAppointmentCard(
                      context: context,
                      name: 'Mohamed Ahmed',
                      time: '10:30am - 11:0am',
                      image: 'assets/patient1.png'
                  ),
                  const SizedBox(height: 16),
                  _buildAppointmentCard(
                      context: context,
                      name: 'Omar Ali',
                      time: '12:00pm - 12:30pm',
                      image: 'assets/patient2.png'
                  ),
                ],
              ),
            ),
          ),
          _buildBottomNavigationBar(),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard({
    required BuildContext context,
    required String name,
    required String time,
    required String image
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 245, 251, 255),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(image, width: 50, height: 50, fit: BoxFit.cover,),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),),
                    const Text('Patient', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 148, 160))),
                    Row(
                      children: [
                        const Icon(Icons.access_time_outlined, color: Colors.grey, size: 16),
                        const SizedBox(width: 4),
                        Text(time, style: const TextStyle(fontSize: 14, color: Colors.grey),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AppointmentScreen()));// Handle view details
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 148, 160),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('View Details'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.0
              )
          )
      ),
      child: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 0, 148, 160),
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'Appointments',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            label: 'Chatbot',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outlined),
            label: 'Profile',
          ),
        ],
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,

        onTap: (index){
          // Handle bottom navigation
        },
      ),
    );
  }
}

// ~~~~~~~~~~~~~~~~~ AppointmentScreen ~~~~~~~~~~~~~~~~~
class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  String _selectedTime = "11.00 AM";
  String _selectedDate = "Sun 4";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // العودة للشاشة السابقة
          },
        ),
        title: const Text('Appointment', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset('assets/patient.png', width: 80, height: 80, fit: BoxFit.cover,),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Ahmed', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                    Text('Patient', style: TextStyle(fontSize: 14, color: Color.fromARGB(255, 0, 148, 160))),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Details',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            const Text(
              'Worem ipsum dolor sit amet, consectetur adipiscing elit. Nunc vulputate libero et velit interdum, ac aliquet odio mattis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur tempus urna at turpis condimentum lobortis. Ut commodo efficitur neque. Ut diam quam, semper iaculis condimentum ac, vestibulum eu nisl.',
              style: TextStyle(color: Colors.black87),
            ),
            const SizedBox(height: 24),
            const Text(
              'Appointment',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildTimeButton("10.00 AM"),
                const SizedBox(width: 8),
                _buildTimeButton("11.00 AM"),
                const SizedBox(width: 8),
                _buildTimeButton("12.00 PM"),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _buildDateButton("Sun 4"),
                const SizedBox(width: 8),
                _buildDateButton("Mon 5"),
                const SizedBox(width: 8),
                _buildDateButton("Tue 6"),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const PatientReportScreen()));// Handle view report
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 148, 160),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('View Patient\'s Report',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildTimeButton(String time) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedTime = time;
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: _selectedTime == time ? const Color.fromARGB(255, 0, 148, 160) : const Color.fromARGB(255, 245, 251, 255),
            foregroundColor: _selectedTime == time ? Colors.white: Colors.black87,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
        ),
        child: Text(time));
  }
  Widget _buildDateButton(String date) {
    return ElevatedButton(
        onPressed: () {
          setState(() {
            _selectedDate = date;
          });
        },
        style: ElevatedButton.styleFrom(
            backgroundColor: _selectedDate == date ? const Color.fromARGB(255, 0, 148, 160) : const Color.fromARGB(255, 245, 251, 255),
            foregroundColor: _selectedDate == date ? Colors.white: Colors.black87,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )
        ),
        child: Text(date));
  }
}

// ~~~~~~~~~~~~~~~~~ PatientReportScreen ~~~~~~~~~~~~~~~~~
class PatientReportScreen extends StatelessWidget {
  const PatientReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // العودة للشاشة السابقة
          },
        ),
        title: const Text('Patient\'s Report'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Patient Details'),
              const SizedBox(height: 16),
              _buildDetailRow('Name:', 'Ahmed'),
              _buildDetailRow('Age:', '32 years'),
              _buildDetailRow('Gender:', 'Male'),
              _buildDetailRow('Phone No:', '7500190739'),
              _buildDetailRow('Address:', 'Lorem ipsum dolor sit'),
              _buildDetailRow('Medical History:', 'No'),
              const SizedBox(height: 24),
              _buildSectionTitle('X-Rays'),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/xray1.png', width: 150, height: 150,),
                  Image.asset('assets/xray2.png', width: 150, height: 150,)
                ],
              ),
              const SizedBox(height: 24),
              _buildSectionTitle('Prediction'),
              const SizedBox(height: 16),
              _buildPredictionText('             High Risk of stroke. Probability : ', '54.72%'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 240, 251, 255),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          Text(
            value,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionText(String label, String value) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 16, color: Colors.black87),
        children: <TextSpan>[
          TextSpan(text: label),
          TextSpan(text: value, style: const TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 0, 148, 160))),
        ],
      ),
    );
  }
}