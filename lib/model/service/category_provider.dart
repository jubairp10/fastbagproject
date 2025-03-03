import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../../view_model/model_class.dart';
import 'package:http/http.dart' as http;

class CategoryProvider extends ChangeNotifier {


  List<Category> _categories = [];
  bool _isLoading = true;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  CategoryProvider() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    final url = "https://fastbag.pythonanywhere.com/vendors/categories/view/";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List data = json.decode(response.body);
        _categories = data.map((json) => Category.fromJson(json)).toList();
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
    _isLoading = false;
    notifyListeners();
  }
}