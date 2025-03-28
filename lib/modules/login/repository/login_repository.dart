

import 'dart:convert';
import 'package:fastbagproject/constants/appurls.dart';
import 'package:flutter_svprogresshud/flutter_svprogresshud.dart';
import 'package:http/http.dart' as http;

class Apiservice {
  static Future registerUser(String mobile) async {
    final url = "${AppUrls.baseUrl}/users/register/";
    try {
      SVProgressHUD.show(); // Show the progress HUD before the request
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile_number': mobile}),
      );
      SVProgressHUD.dismiss(); // Dismiss the progress HUD after the request

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(jsonDecode(response.body)['error'] ?? "Failed to send OTP");
      }
    } catch (e) {
      SVProgressHUD.dismiss(); // Ensure the HUD is dismissed in case of an error
      throw Exception("Error registering user: $e");
    }
  }

  static Future<bool> verifyOtp(String mobile, String otp) async {
    final url = "${AppUrls.baseUrl}/users/login/";
    try {
      SVProgressHUD.show(); // Show the progress HUD before the request
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile_number': mobile, 'otp': otp}),
      );
      SVProgressHUD.dismiss(); // Dismiss the progress HUD after the request

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Invalid OTP");
      }
    } catch (e) {
      SVProgressHUD.dismiss(); // Ensure the HUD is dismissed in case of an error
      throw Exception("Error verifying OTP: $e");
    }
  }
}
