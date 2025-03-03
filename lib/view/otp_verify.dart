
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';
import '../model/service/auth_provider.dart';
import 'home.dart';


class OtpVerificationScreen extends StatefulWidget {
  final String mobileNumber;

  OtpVerificationScreen({super.key, required this.mobileNumber});

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _otpFocusNode = FocusNode();
  int _resendTime = 9;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      FocusScope.of(context).requestFocus(_otpFocusNode); // ✅ Auto-focus OTP field
    });
  }

  @override
  void dispose() {
    _otpFocusNode.dispose();
    super.dispose();
  }

  void _verifyOtp() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    authProvider.verifyOtp(widget.mobileNumber, _otpController.text.trim()).then((_) {
      print("Verification status: ${authProvider.isVerified}");
      if (authProvider.isVerified) { // Ensure user is verified before navigation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Successful')),
        );
        print("Navigating to HomeScreen: ${authProvider.isVerified}");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
        );
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('OTP verification failed.')),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP')),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text("OTP Verification")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Enter the 4-digit code sent to you at${widget.mobileNumber}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
              SizedBox(height: 5),
              const SizedBox(height: 20),
              Pinput(
                length: 6,
                controller: _otpController,
                focusNode: _otpFocusNode, // ✅ Attach focus node
                onCompleted: (pin) => _verifyOtp(),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: _canResend ? () {} : null,
                child: Text("I haven’t received a code (${_resendTime.toString().padLeft(2, '0')})"),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey,
                  disabledForegroundColor: Colors.grey,
                ),
              ),
              TextButton(
                onPressed: () {}, // Implement login with password
                child: Text("Log in with password"),
              ),
              Spacer(),
          Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    onPressed: _verifyOtp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                    child: Text("Verify", style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: _verifyOtp,
              //   child: const Text("Verify"),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
