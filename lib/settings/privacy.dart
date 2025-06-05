import 'package:flutter/material.dart';


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center the title
          children: [
            Text('Privacy Policy'),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Handle back button press here (e.g., Navigator.pop)
            Navigator.pop(context); //  This is the correct way to go back
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Your privacy is important to us. It is Brainstorming\'s policy to respect your privacy regarding any information we may collect from you.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            Text(
              'We only ask for personal information when we truly need it to provide a service to you. We collect it by fair and lawful means, with your knowledge and consent. We also let you know why we\'re collecting it and how it will be used.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            Text(
              'We only retain collected information for as long as necessary to provide you with your requested service. What data we store, we\'ll protect within commercially acceptable means to prevent loss and theft, as well as unauthorized access, disclosure, copying, use or modification.',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 16.0),

            Text(
              'We don\'t share any personally identifying information publicly or with third-parties, except when required to by law.',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}