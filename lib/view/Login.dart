
import 'package:fastbagproject/view/home.dart';
import 'package:fastbagproject/view/widget/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../model/service/auth_provider.dart';

import 'otp_verify.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = "+91"; // Default India code

  void _sendOtp() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final mobile = '$_selectedCountryCode${_phoneController.text.trim()}';

    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    authProvider.registerUser(mobile).then((_) {
      print("Navigating to OTP screen with mobile: $mobile");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OtpVerificationScreen(mobileNumber: mobile),
        ),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString())),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
               SizedBox(height: 100),
              Center(
                child: Text(
                  'Login or create an account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IntlPhoneField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Your Phone Number'),
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    _selectedCountryCode = phone.countryCode;
                  },
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavExample()));
                },
                child: const Text('Continue'),
              ),
              Expanded(
                child: Column(
                  children: [
      
                    Spacer(), // Pushes the following content to the bottom
                    Text('By clicking "Continue" you agree with', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Our ', style: TextStyle(fontSize: 16, color: Colors.grey)),
                        TextButton(
                          onPressed: () {

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerificationScreen(mobileNumber: 'mobile_number')));
                          },
                          child: Text('Terms and Conditions', style: TextStyle(fontSize: 16, color: Colors.black)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    InkWell(
                      onTap: _sendOtp,
                      child: Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                        child: Center(child: Text('Continue', style: TextStyle(fontSize: 16, color: Colors.white))),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

