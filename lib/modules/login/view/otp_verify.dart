

import 'package:fastbagproject/constants/app_color.dart';
import 'package:fastbagproject/constants/app_fonts.dart';
import 'package:fastbagproject/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';

import '../../../common/widget/bottom_nav_bar.dart';
import '../view_model/auth_view_model.dart';


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
    final authProvider = Provider.of<AuthViewModel>(context, listen: false);
    authProvider.verifyOtp(widget.mobileNumber, _otpController.text.trim()).then((_) {
      print("Verification status: ${authProvider.isVerified}");
      if (authProvider.isVerified) { // Ensure user is verified before navigation
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(registersucccess)),
        );
        print("Navigating to HomeScreen: ${authProvider.isVerified}");

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomNavExample()),
                (route) => false,
        );
      }else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(otpVerificationfailed)),
        );
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(otpField)),
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
            Text("Enter the 4-digit code sent to you at\n${widget.mobileNumber}",
                  style:MainFont(fontsize: 20, fontweight: FontWeight.w500, color: AppColors.black)),
              SizedBox(height: 5),
              const SizedBox(height: 20),
              Pinput(
                length: 6,
                controller: _otpController,
                focusNode: _otpFocusNode, // ✅ Attach focus node
                onCompleted: (pin) => _verifyOtp(),
              ),
              SizedBox(height: 20),
              Container(decoration: BoxDecoration(color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(20)
              ),
                child: TextButton(
                  onPressed: _canResend ? () {} : null,
                  child: Text("I haven’t received a code (${_resendTime.toString().padLeft(2, '0')})",
                  style: MainFont(fontsize: 16, fontweight: FontWeight.w500, color: Colors.grey),),

                ),
              ),
              SizedBox(height: 10,),
              Container(decoration: BoxDecoration(color: Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(20)),

                child: TextButton(
                  onPressed: () {}, // Implement login with password
                  child: Text("Log in with password",style: MainFont(fontsize: 16, fontweight: FontWeight.w500, color: AppColors.black),),
                ),
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
                      backgroundColor: AppColors.switchcolor,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                    ),
                    child: Text("Verify", style: MainFont(fontsize: 18, fontweight: FontWeight.w700, color: AppColors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 20),

            ],
          ),
        ),
      ),
    );
  }
}
