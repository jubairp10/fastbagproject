import 'package:flutter/material.dart';
import '../model/list_shop_class.dart';
import '../repository/shoplist_repository.dart';

class StoreViewModel extends ChangeNotifier {
  final ShopApiService _apiService = ShopApiService();
  List<Store> _stores = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Store> get stores => _stores;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  StoreViewModel() {
    fetchStores();
  }

  Future<void> fetchStores() async {
    _isLoading = true;
    notifyListeners();

    try {
      _stores = await _apiService.fetchStores();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'An error occurred: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  void toggleFavoriteStatus(int storeId) async {
    final index = _stores.indexWhere((store) => store.id == storeId);
    if (index != -1) {
      final currentStatus = _stores[index].isFavorite;
      _stores[index].isFavorite = !currentStatus;
      notifyListeners();

      // Update the server
      final success = await _apiService.updateFavoriteStatus(storeId, !currentStatus);
      if (!success) {
        // Revert the change if the server update fails
        _stores[index].isFavorite = currentStatus;
        notifyListeners();
      }
    }
  }

}
