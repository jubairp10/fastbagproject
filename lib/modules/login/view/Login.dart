
import 'package:fastbagproject/constants/app_color.dart';
import 'package:fastbagproject/constants/app_fonts.dart';
import 'package:fastbagproject/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


import '../../../common/widget/bottom_nav_bar.dart';
import '../view_model/auth_view_model.dart';
import 'otp_verify.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  String _selectedCountryCode = "+91"; // Default India code

  void _sendOtp() {
    final authProvider = Provider.of<AuthViewModel>(context, listen: false);
    final mobile = '$_selectedCountryCode${_phoneController.text.trim()}';

    if (_phoneController.text.isEmpty || _phoneController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(phonefieldrequired)),
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
        body: SingleChildScrollView( // Wrap with SingleChildScrollView
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(height: 50),
                Container(
                  height: 500,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'Login or create an account',
                          style: LoginFont(fontsize: 50, fontweigt: FontWeight.w400, color: AppColors.black),
                        ),
                      ),
                      SizedBox(height: 150),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IntlPhoneField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                            labelText: 'Your Phone Number',
                            labelStyle: Normalfont2(fontsize: 18, color: AppColors.black, fontweigt: FontWeight.w400),
                            border: InputBorder.none, // Removes the default underline
                            counterText: '', // Removes the character counter
                          ),
                          dropdownIcon: Icon( Icons.arrow_drop_down,
                            size: 20,),
                          dropdownTextStyle: Normalfont2(fontsize: 18, color: AppColors.black, fontweigt: FontWeight.w400),
                          initialCountryCode: 'IN',
                          enabled: true, // Disables the entire field, including the country selector
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly, // Allows only digits
                            // FilteringTextInputFormatter.deny(RegExp(r'^0+')), // Prevents leading zeros
                          ],
                          onChanged: (phone) {
                            _selectedCountryCode = phone.countryCode;
                          },
                        )

                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 150),
               
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('By clicking "Continue" you agree with',
                      style: Normalfont(fontsize: 16, fontweigt: FontWeight.w700, color: Colors.grey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Our ', style: Normalfont(fontsize: 16, fontweigt: FontWeight.w700, color: Colors.grey),),
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => OtpVerificationScreen(mobileNumber: 'mobile_number')));
                          },
                          child: Text('Terms and Conditions', style: Normalfont(fontsize: 16, fontweigt: FontWeight.w700, color: AppColors.black),
                        ),
                        )],
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: _sendOtp,
                      child: Container(
                        height: 56,
                        width: 363.71,
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(60)),
                        child: Center(child: Text('Continue', style:Normalfont2(fontsize: 16, fontweigt: FontWeight.w700, color: Colors.white))),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

