import 'package:flutter/material.dart';


class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _showNotifications = true;
  bool _enableSound = false;
  bool _showPreview = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            // Handle back button press
          },
        ),
        title: const Text('Notifications', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 245, 245),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Show notification', style: TextStyle(fontSize: 16),),
                  Switch(
                      activeColor: const Color.fromARGB(255, 0, 148, 160),
                      value: _showNotifications,
                      onChanged: (bool value){
                        setState(() {
                          _showNotifications = value;
                        });
                      }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 245, 245),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Sound', style: TextStyle(fontSize: 16),),
                  Switch(
                      activeColor: const Color.fromARGB(255, 0, 148, 160),
                      value: _enableSound,
                      onChanged: (bool value){
                        setState(() {
                          _enableSound = value;
                        });
                      }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 245, 245, 245),
                  borderRadius: BorderRadius.circular(8)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Show preview', style: TextStyle(fontSize: 16),),
                  Switch(
                      activeColor: const Color.fromARGB(255, 0, 148, 160),
                      value: _showPreview,
                      onChanged: (bool value){
                        setState(() {
                          _showPreview = value;
                        });
                      }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}