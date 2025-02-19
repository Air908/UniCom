import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/features/auth/presentation/interest_selection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String gender = "Male";
  DateTime? selectedDate;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Custom text field decoration
  InputDecoration _getInputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor.withOpacity(0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey[50],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validateAge(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }
    final age = int.tryParse(value);
    if (age == null || age < 0 || age > 120) {
      return 'Enter a valid age between 0 and 120';
    }
    return null;
  }

  Future<void> registerUser() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      try {
        // Check if username already exists
        final usernameQuery = await _firestore
            .collection("users")
            .where("username", isEqualTo: userNameController.text)
            .get();

        if (usernameQuery.docs.isNotEmpty) {
          _showErrorDialog('Username already exists');
          return;
        }

        await _firestore.collection("users").add({
          "name": nameController.text.trim(),
          "username": userNameController.text.trim(),
          "phone": phoneController.text.trim(),
          "gender": gender,
          "age": int.parse(ageController.text.trim()),
          "dob": selectedDate?.toIso8601String(),
          "address": addressController.text.trim(),
          "account_created": FieldValue.serverTimestamp(),
        });

        _showSuccessDialog();
      } catch (e) {
        _showErrorDialog(e.toString());
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
        content: const Text('Registration completed successfully!'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to login or home screen
            },
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Register"),
          IconButton(onPressed: (){
            Get.offAll(InterestsScreen());
          }, icon: Icon(Icons.skip_next))
          ],
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Create Account',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Form fields with spacing
                  TextFormField(
                    controller: nameController,
                    decoration: _getInputDecoration('Full Name', Icons.person),
                    validator: (value) => value?.isEmpty ?? true ? 'Name is required' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: userNameController,
                    decoration: _getInputDecoration('Username', Icons.account_circle),
                    validator: (value) => value?.isEmpty ?? true ? 'Username is required' : null,
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: _getInputDecoration('Phone Number', Icons.phone),
                    validator: _validatePhone,
                  ),
                  const SizedBox(height: 16),

                  DropdownButtonFormField<String>(
                    value: gender,
                    decoration: _getInputDecoration('Gender', Icons.people),
                    items: ["Male", "Female", "Other"].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        gender = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: ageController,
                    keyboardType: TextInputType.number,
                    decoration: _getInputDecoration('Age', Icons.calendar_today),
                    validator: _validateAge,
                  ),
                  const SizedBox(height: 16),

                  // Date of Birth Picker
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.5)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.cake, color: Theme.of(context).primaryColor),
                      title: Text(
                        selectedDate == null
                            ? 'Select Date of Birth'
                            : 'DOB: ${DateFormat('MMM dd, yyyy').format(selectedDate!)}',
                      ),
                      trailing: Icon(Icons.arrow_drop_down, color: Theme.of(context).primaryColor),
                      onTap: _pickDate,
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: addressController,
                    decoration: _getInputDecoration('Address', Icons.location_on),
                    maxLines: 3,
                    validator: (value) => value?.isEmpty ?? true ? 'Address is required' : null,
                  ),
                  const SizedBox(height: 24),

                  ElevatedButton(
                    onPressed: _isLoading ? null : registerUser,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Register',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    phoneController.dispose();
    ageController.dispose();
    addressController.dispose();
    super.dispose();
  }
}