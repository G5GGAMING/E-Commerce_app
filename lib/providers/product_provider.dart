import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();

      final cachedData = prefs.getString('cached_products');
      if (cachedData != null) {
        final decoded = jsonDecode(cachedData) as List;
        _products = decoded.map((e) => Product.fromJson(e)).toList();
        notifyListeners();
      }

      final apiProducts = await ApiService.fetchProducts();

      final favData = prefs.getString('favorites');

      List<int> favIds = [];

      if (favData != null) {
        final decoded = jsonDecode(favData) as List;

        favIds = decoded.map<int>((e) => (e as num).toInt()).toList();
      }

      for (var product in apiProducts) {
        product.isFavorite = favIds.contains(product.id);
      }

      _products = apiProducts;

      await prefs.setString(
        'cached_products',
        jsonEncode(_products.map((e) => e.toJson()).toList()),
      );
    } catch (e) {
      print("API Error: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
