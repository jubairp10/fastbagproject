// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// class AuthProvider with ChangeNotifier {
//
//   bool _isOtpSent = false;
//   bool _isVerified = false;
//   bool _canResend = true;
//   int _resendTime = 30;
//
//   bool get isOtpSent => _isOtpSent;
//   bool get isVerified => _isVerified;
//   bool get canResend => _canResend;
//   int get resendTime => _resendTime;
//   // bool get isVerified {
//   //   final prefs = SharedPreferences.getInstance();
//   //   return prefs.containsKey('user_mobile');
//   // }
//
//
//   Future<void> registerUser(String mobile) async {
//     try {
//       final response = await http.post(
//         Uri.parse('https://fastbag.pythonanywhere.com/users/register/'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode({'mobile_number': mobile}),
//       );
//
//       print("Registration Response: ${response.body}");
//       print("OTP Sent Status: $_isOtpSent");
//
//       if (response.statusCode == 200) {
//         _isOtpSent = true;
//         startResendTimer();
//         notifyListeners();
//       } else {
//         throw Exception(jsonDecode(response.body)['error'] ?? 'Failed to send OTP');
//       }
//     } catch (e) {
//       throw Exception('Failed to connect: ${e.toString()}');
//     }
//   }
//
//
//   // Modify verifyOtp
//   Future<void> verifyOtp(String mobile, String otp) async {
//     final response = await http.post(
//       Uri.parse('https://fastbag.pythonanywhere.com/users/login/'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({'mobile_number': mobile, 'otp': otp}),
//     );
//     print("OTP Verification Response: ${response.body}");
//     if (response.statusCode == 200) {
//       final prefs = await SharedPreferences.getInstance();
//       await prefs.setString("user_mobile",mobile);
//       _isVerified = true; // ✅ Mark as verified
//       notifyListeners();
//       print("User verified successfully"); // ✅ Notify listeners
//     } else {
//       throw Exception('Invalid OTP');
//     }
//   }
//
//
//
//   void startResendTimer() {
//     _resendTime = 30;
//     _canResend = false;
//     notifyListeners();
//
//     Future.delayed(Duration(seconds: _resendTime), () {
//       _canResend = true;
//       notifyListeners();
//     });
//   }
//   Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.remove('user_mobile');
//     _isVerified = false;
//     _isOtpSent = false;
//     notifyListeners();
//   }
// }
