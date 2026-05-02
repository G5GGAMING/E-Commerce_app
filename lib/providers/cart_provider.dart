import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'dart:async';
class CartItem {
  final Product product;
  int quantity;
  CartItem({required this.product, this.quantity = 1});
}
class OrderItem {
  final String id;
  final List<CartItem> products;
  final double total;
  String status; 
  OrderItem({
    required this.id,
    required this.products,
    required this.total,
    this.status = "Reviewing",
  });
}
class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {}; 
  List<OrderItem> _orders = [];      
  Map<String, CartItem> get items => {..._items};
  List<OrderItem> get orders => [..._orders];
  int get itemCount => _items.length;
  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.product.price * cartItem.quantity;
    });
    return total;
  }
  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => CartItem(
          product: existingItem.product,
          quantity: existingItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(product: product),
      );
    }
    notifyListeners();
  }
  void checkout() {
    if (_items.isEmpty) return;
    final newOrder = OrderItem(
      id: DateTime.now().toString(),
      products: _items.values.toList(),
      total: totalAmount,
      status: "Reviewing",
    );
    _orders.add(newOrder);
    _items = {}; 
    notifyListeners(); 
    Timer(const Duration(seconds: 10), () {
      newOrder.status = "Received";
      notifyListeners(); 
    });
  }
  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) return;
    if (_items[productId]!.quantity > 1) {
      _items.update(productId, (ex) => CartItem(product: ex.product, quantity: ex.quantity - 1));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }
  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }
  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
