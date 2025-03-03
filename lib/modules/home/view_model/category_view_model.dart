import 'package:flutter/material.dart';
import '../model/model_class.dart';
import '../repository/home_repository.dart';

class CategoryViewModel extends ChangeNotifier {
  final HomeApiservices _apiService = HomeApiservices();
  bool _isLoading = true;
  List<Category> _categories = [];

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  CategoryViewModel() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    try {
      _categories = await _apiService.fetchCategories();
    } catch (e) {
      // Handle errors properly
      print('Error fetching categories: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
