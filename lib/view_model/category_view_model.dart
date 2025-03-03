import 'package:flutter/material.dart';
import '../model/model_class.dart';
import '../model/service/api_services.dart';


class CategoryViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Category> _categories = [];
  bool _isLoading = true;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;

  CategoryViewModel() {
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    _isLoading = true;
    notifyListeners();
    _categories = await _apiService.fetchCategories();
    _isLoading = false;
    notifyListeners();
  }
}
