import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';
import 'package:mohammed_ashraf/screens/appointment_enrolled.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  _AddCardScreenState createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {
  bool agreeToTerms = false;
  bool saveCardDetails = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Card', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: _buildCardPreview()),
            SizedBox(height: 30),
            Text(
              'Enter card details',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 15),
            _buildTextField('Card name', 'Enter cardholder name'),
            SizedBox(height: 10),
            _buildTextField('Card number', 'Enter card number'),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: _buildTextField('Expiry date', 'MM/YY'),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _buildTextField('CVV', '***'),
                ),
              ],
            ),
            SizedBox(height: 20),
            _buildAgreementCheckbox(),
            _buildCheckbox('Save card details', saveCardDetails, (value) {
              setState(() {
                saveCardDetails = value!;
              });
            }),
            SizedBox(height: 30),
            _buildAddCardButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCardPreview() {
     return SizedBox(
    width: 350, // set desired width here
    child: Image.asset("assets/images/master_card.png"),
  );
  }

  Widget _buildTextField(String label, String hint) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildCheckbox(String title, bool value, Function(bool?) onChanged) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: MyColors.mainColor,
    );
  }

  Widget _buildAgreementCheckbox() {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: MyColors.mainColor,
      value: agreeToTerms,
      onChanged: (value) {
        setState(() {
          agreeToTerms = value!;
        });
      },
      title: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'I agree to the ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'Terms and conditions',
              style: TextStyle(color: MyColors.mainColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddCardButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
      ),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AppointmentEnrolledScreen()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.mainColor,
          padding: EdgeInsets.symmetric(vertical: 16),
        ),
        child: Text('Add Card', style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
