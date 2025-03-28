import 'package:flutter/material.dart';
import '../model/favaroite_vendor_class.dart';
import '../repository/favaroite_vendor_repository.dart';

class FavoriteVendorViewModel extends ChangeNotifier {
final FavoriteVendorService _service=FavoriteVendorService();

  List<FavoriteVendor> _favoriteVendors = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<FavoriteVendor> get favoriteVendors => _favoriteVendors;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchFavoriteVendors({required int vendorId}) async {
    _isLoading = true;
    notifyListeners();

    try {
      _favoriteVendors = await _service.fetchFavoriteVendors(vendorId);
      _errorMessage = null;
    } catch (e) {
      _errorMessage = _handleError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String _handleError(dynamic e) {
    if (e.toString().contains('401')) {
      return 'Session expired. Please log in again.';
    }
    return 'Failed to load favorite vendors. Please try again.';
  }
}
