import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model_class.dart';


class ApiService {
  static const String baseUrl = "https://fastbag.pythonanywhere.com";

  // Fetch Categories
  Future<List<Category>> fetchCategories() async {
    final url = "$baseUrl/vendors/categories/view/";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        return data.map((json) => Category.fromJson(json)).toList();
      } else {
        // Handle non-200 status codes
        print('Failed to load categories');
        return [];
      }
    } catch (e) {
      print("Error fetching categories: $e");
      return [];
    }
  }

  // Register User
  static Future<bool> registerUser(String mobile) async {
    final url = "$baseUrl/users/register/";

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
    final url = "$baseUrl/users/login/";

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
