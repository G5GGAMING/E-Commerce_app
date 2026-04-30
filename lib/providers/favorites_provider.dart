import 'package:flutter/material.dart';
import '../models/product_model.dart';

class FavoritesProvider with ChangeNotifier {
  List<Product> _favoriteItems = [];

  List<Product> get favoriteItems => [..._favoriteItems];

  bool isFavorite(Product product) {
    return _favoriteItems.contains(product);
  }

  void toggleFavorite(Product product) {
    if (_favoriteItems.contains(product)) {
      _favoriteItems.remove(product);
      product.isFavorite = false;
    } else {
      _favoriteItems.add(product);
      product.isFavorite = true;
    }
    notifyListeners();
  }

  void removeFavorite(String productId) {
    _favoriteItems.removeWhere((prod) => prod.id == productId);
    notifyListeners();
  }
}
