import 'package:flutter/material.dart';
import 'package:mohammed_ashraf/core/core.dart';
import 'package:mohammed_ashraf/screens/appointment_enrolled.dart';
import 'package:mohammed_ashraf/screens/card_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String selectedPaymentMethod = 'Master Card';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Payment', style: TextStyle(color: Colors.black))),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildPaymentOption('Apple Pay', Icons.apple, 'Apple Pay'),
                      _buildPaymentOption('Pay Pal', Icons.paypal, 'Pay Pal'),
                      _buildPaymentOption('Master Card', Icons.credit_card, 'Master Card'),
                      SizedBox(height: 20),
                      Text('Choose Card', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      SizedBox(height: 10),
                      _buildCardOption('**** **** **** 2478', Icons.credit_card),
                      SizedBox(height: 20),
                      _buildAddCardButton(),
                      SizedBox(height: 20),
                      _buildPurchaseInfo(),
                      SizedBox(height: 20),
                      _buildConfirmButton(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title),
      trailing: Radio<String>(
        value: value,
        groupValue: selectedPaymentMethod,
        onChanged: (String? newValue) {
          setState(() {
            selectedPaymentMethod = newValue!;
          });
        },
        activeColor: Colors.teal,
      ),
    );
  }

  Widget _buildCardOption(String cardNumber, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.red),
        labelText: cardNumber,
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildAddCardButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3)
      ),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
            AddCardScreen()));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Add Card'),
            Container(
              decoration: BoxDecoration(
                color: MyColors.mainColor,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(Icons.add, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPurchaseInfo() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.thirdColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Purchase Information:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildPurchaseDetail('Appointment price', '\$60.00'),
          _buildPurchaseDetail('Discount', '\$3.00'),
          _buildPurchaseDetail('Total cost', '\$57.00', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildPurchaseDetail(String title, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: isTotal ? TextStyle(fontWeight: FontWeight.bold) : null),
          Text(amount, style: isTotal ? TextStyle(fontWeight: FontWeight.bold, color: Colors.teal) : null),
        ],
      ),
    );
  }

  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3)
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>
            AppointmentEnrolledScreen()));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyColors.mainColor,
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text('Confirm', style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
