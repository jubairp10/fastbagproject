import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fastbagproject/constants/appurls.dart';
import '../model/list_shop_class.dart';

class ShopApiService {
  Future<List<Store>> fetchStores() async {
    final response = await http.get(Uri.parse('${AppUrls.baseUrl}/vendors/vendors-home/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((store) => Store.fromJson(store)).toList();
    } else {
      throw Exception('Failed to load stores');
    }
  }

  Future<bool> updateFavoriteStatus(int vendorId, bool isFavorite) async {
    print("vendor Id  $vendorId");
    print("favor ${isFavorite}");

    final url = Uri.parse('${AppUrls.baseUrl}/vendors/vendor/favourite/$vendorId/');
    final response = await http.put(
      headers: {
        'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzcyNzcyNDE3LCJpYXQiOjE3NDEyMzY0MTcsImp0aSI6ImU0OWVmYmZmNTNkZTRkZTI4MTViNjJkMmRiZjlmOGVmIiwidXNlcl9pZCI6MjV9.9kTfrfbY0LqUUqngVgVI5Q0E9agkmwFKGGjzqTfcMNI', // Attach token here
        'Content-Type': 'application/json',
      },
      url,
      body: jsonEncode({'is_favorite': isFavorite}),
    );

    if (response.statusCode == 200) {
      print("success");
      return true;
    } else {
      print("reponse ${response.statusCode}");
      print('Failed to update favorite status: ${response.reasonPhrase}');
      return false;
    }
  }
}
