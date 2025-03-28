import 'dart:convert';
import 'package:fastbagproject/constants/appurls.dart';
import 'package:http/http.dart' as http;

import '../model/model_class.dart';

class HomeApiservices{



  // Fetch Categories
  Future<List<Category>> fetchCategories() async {
    final url = "${AppUrls.baseUrl}/vendors/categories/view/";
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

}