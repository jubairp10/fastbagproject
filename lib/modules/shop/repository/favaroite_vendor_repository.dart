import 'dart:convert';
import 'package:fastbagproject/constants/appurls.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/favaroite_vendor_class.dart';

class FavoriteVendorService {
  Future<List<FavoriteVendor>> fetchFavoriteVendors(int vendorId) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    final response = await http.get(
      Uri.parse('${AppUrls.baseUrl}/vendors/vendor/favourite/$vendorId/'),
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcyNzcyNDE3LCJpYXQiOjE3NDEyMzY0MTcsImp0aSI6ImU0OWVmYmZmNTNkZTRkZTI4MTViNjJkMmRiZjlmOGVmIiwidXNlcl9pZCI6MjV9.9kTfrfbY0LqUUqngVgVI5Q0E9agkmwFKGGjzqTfcMNI', // Attach token here
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => FavoriteVendor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load favorite vendors');
    }
  }
}
