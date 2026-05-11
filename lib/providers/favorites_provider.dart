import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';

class FavoritesProvider with ChangeNotifier {
  final List<int> _favoriteIds = [];

  List<int> get favoriteIds => [..._favoriteIds];

  FavoritesProvider() {
    initFavorites();
  }

  bool isFavorite(Product product) {
    return _favoriteIds.contains(product.id);
  }

  Future<void> initFavorites() async {
    await loadFavorites();
  }

  Future<void> toggleFavorite(Product product) async {
    if (_favoriteIds.contains(product.id)) {
      _favoriteIds.remove(product.id);
      product.isFavorite = false;
    } else {
      _favoriteIds.add(product.id);
      product.isFavorite = true;
    }

    await saveFavorites();
    notifyListeners();
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'favorites',
      jsonEncode(_favoriteIds),
    );
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('favorites');

    if (data == null) return;

    try {
      final decoded = jsonDecode(data) as List;

      _favoriteIds
        ..clear()
        ..addAll(decoded.map((e) => (e as num).toInt()));

      notifyListeners();
    } catch (e) {
      print("Favorites Load Error: $e");
    }
  }

  void syncWithProducts(List<Product> products) {
    for (var product in products) {
      product.isFavorite = _favoriteIds.contains(product.id);
    }

    notifyListeners();
  }

  Future<void> removeFavorite(int productId) async {
    _favoriteIds.remove(productId);
    await saveFavorites();
    notifyListeners();
  }
}
