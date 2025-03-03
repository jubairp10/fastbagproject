import 'dart:convert';

import '../../home/model/model_class.dart';
import 'package:http/http.dart' as http;

class Apiservice{
  final  String baseUrl="https://fastbag.pythonanywhere.com";




  static Future<bool> registerUser(String mobile) async {
    final url = "https://fastbag.pythonanywhere.com/users/register/";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile_number': mobile}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(jsonDecode(response.body)['error'] ?? "Failed to send OTP");
      }
    } catch (e) {
      throw Exception("Error registering user: $e");
    }
  }

  // Verify OTP
  static Future<bool> verifyOtp(String mobile, String otp) async {
    final url = "https://fastbag.pythonanywhere.com/users/login/";

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile_number': mobile, 'otp': otp}),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception("Invalid OTP");
      }
    } catch (e) {
      throw Exception("Error verifying OTP: $e");
    }
  }
}