import 'package:flutter/material.dart';



class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {},
        ),
        title: const Text('Notifications',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        centerTitle: true,
        actions: [
          Container(
            width: 50,
            height: 30,
            margin: const EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: Colors.teal.shade300,
              borderRadius: BorderRadius.circular(5),
            ),
            child: const Center(
              child: Text('1 New', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const Text("TODAY", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("Mark all as read",
                    style: TextStyle(color: Colors.teal)),
              ),
            ],
          ),
          NotificationTile(
            icon: Icons.description_outlined,
            title: "New Patient Test Results",
            subtitle: "Test results for Ahmed are ready for review",
            time: "1h",
          ),
          NotificationTile(
            icon: Icons.calendar_month,
            title: "Upcoming Appointment",
            subtitle: "Your appointment with Ahmed is at 7:00 PM",
            time: "2h",
          ),
          NotificationTile(
              icon: Icons.warning,
              iconColor: Colors.red.shade200,
              title: "Urgent Attention Required",
              subtitle:
              "Critical condition for Mohamed. Immediate evaluation needed",
              time: "8h"),
          const SizedBox(height: 16),
          const Text("YESTERDAY",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {},
                child: const Text("Mark all as read",
                    style: TextStyle(color: Colors.teal)),
              ),
            ],
          ),
          NotificationTile(
            icon: Icons.edit_calendar,
            title: "New Consultation Request",
            subtitle: "Patient Ali has requested a consultation",
            time: "1d",
          ),
        ],
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;
  final Color? iconColor;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
    this.iconColor = Colors.teal,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: iconColor,
        radius: 25,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: Text(time, style: const TextStyle(color: Colors.grey)),
    );
  }
}