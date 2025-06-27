import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:mohammed_ashraf/features/auth/login.dart';
import 'package:mohammed_ashraf/features/auth/providers/register_provider.dart';
import 'package:provider/provider.dart';

class RegistreScreenSecond extends StatefulWidget {
  const RegistreScreenSecond({super.key});

  @override
  State<RegistreScreenSecond> createState() => _RegistreScreenSecondState();
}

class _RegistreScreenSecondState extends State<RegistreScreenSecond> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _feeController = TextEditingController();

  // Dropdown values
  String? _selectedGender;
  String? _selectedCountry;
  String? _selectedAcademicDegree;

  Country selectedCountry = Country(
    phoneCode: '1',
    countryCode: 'US',
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: 'United States',
    example: '2015550123',
    displayName: 'United States',
    displayNameNoCountryCode: 'US',
    e164Key: '',
  );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _feeController.dispose();
    super.dispose();
  }

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<RegistrationProvider>();
      provider.clearError();

      final fullPhone = '${selectedCountry.phoneCode}${_phoneController.text}';

      await provider.register(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
        email: _emailController.text,
        password: _passwordController.text,
        dateOfBirth: _dateController.text,
        gender: _selectedGender!,
        phone: fullPhone,
        country: _selectedCountry!,
        address: _addressController.text,
        specialization: _selectedAcademicDegree!,
        appointmentFee: int.parse(_feeController.text),
      );

      if (provider.errorMessage == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<RegistrationProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Register'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset('assets/images/Logo.png', height: 100),
              ),
              const SizedBox(height: 20),
              _buildTextField('First Name', 'Enter first name', _firstNameController),
              _buildTextField('Last Name', 'Enter last name', _lastNameController),
              _buildTextField('Email', 'Enter email', _emailController, isEmail: true),
              _buildPasswordField(),
              _buildDatePicker(context),
              _buildDropdown('Gender', ['Male', 'Female'], (v) => _selectedGender = v),
              _buildPhoneNumberField(),
              _buildDropdown('Country', ['USA', 'Egypt', 'India', 'Canada'],
                      (v) => _selectedCountry = v),
              _buildTextField('Address', 'Enter address', _addressController),
              _buildDropdown('Academic Degree', ['Bachelor', 'Master', 'PhD'],
                      (v) => _selectedAcademicDegree = v),
              _buildTextField('Appointment Fee', 'Enter fee', _feeController, isNumber: true),

              // Error message display
              if (provider.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    provider.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),

              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : () => _submitForm(context),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color.fromRGBO(27, 132, 153, 0.89),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      disabledBackgroundColor: Colors.grey,
                    ),
                    child: provider.isLoading
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                        : const Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller,
      {bool isEmail = false, bool isNumber = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: isEmail ? TextInputType.emailAddress :
        isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          }
          if (isEmail && !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
            return 'Enter valid email';
          }
          if (isNumber && int.tryParse(value) == null) {
            return 'Enter valid number';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          labelText: 'Password',
          hintText: 'Enter password',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.visibility),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) return 'Password required';
          if (value.length < 6) return 'At least 6 characters';
          return null;
        },
      ),
    );
  }

  Widget _buildDatePicker(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _dateController,
        readOnly: true,
        decoration: const InputDecoration(
          labelText: 'Date Of Birth',
          hintText: 'Select date',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.calendar_today),
        ),
        onTap: () async {
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime(2000),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (picked != null) {
            setState(() {
              _dateController.text =
              "${picked.year}-${picked.month.toString().padLeft(2,'0')}"
                  "-${picked.day.toString().padLeft(2,'0')}";
            });
          }
        },
        validator: (value) {
          if (value == null || value.isEmpty) return 'Date required';
          return null;
        },
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        items: items.map((item) =>
            DropdownMenuItem(value: item, child: Text(item))
        ).toList(),
        onChanged: onChanged,
        validator: (value) => value == null ? 'Please select $label' : null,
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => showCountryPicker(
              context: context,
              showPhoneCode: true,
              onSelect: (Country country) {
                setState(() => selectedCountry = country);
              },
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                children: [
                  Text('${selectedCountry.flagEmoji} +${selectedCountry.phoneCode}'),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile Phone',
                hintText: 'Enter phone number',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Phone required';
                if (!RegExp(r'^[0-9]{6,15}$').hasMatch(value)) {
                  return 'Enter valid number';
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}