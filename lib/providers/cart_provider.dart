import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({
    required this.product,
    this.quantity = 1,
  });

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: Product.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'products': products.map((e) => e.toJson()).toList(),
        'total': total,
        'status': status,
      };

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      products:
          (json['products'] as List).map((e) => CartItem.fromJson(e)).toList(),
      total: (json['total'] as num).toDouble(),
      status: json['status'],
    );
  }
}

class CartProvider with ChangeNotifier {
  Map<int, CartItem> _items = {};
  List<OrderItem> _orders = [];

  Map<int, CartItem> get items => {..._items};
  List<OrderItem> get orders => [..._orders];

  int get itemCount => _items.length;

  double get totalAmount {
    double total = 0;
    _items.forEach((key, item) {
      total += item.product.price * item.quantity;
    });
    return total;
  }

  CartProvider() {
    loadCart();
    loadOrders();
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existing) => CartItem(
          product: existing.product,
          quantity: existing.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(product: product),
      );
    }

    saveCart();
    notifyListeners();
  }

  void removeSingleItem(int productId) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (existing) => CartItem(
          product: existing.product,
          quantity: existing.quantity - 1,
        ),
      );
    } else {
      _items.remove(productId);
    }

    saveCart();
    notifyListeners();
  }

  void removeItem(int productId) {
    _items.remove(productId);
    saveCart();
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    saveCart();
    notifyListeners();
  }

  void checkout() {
    if (_items.isEmpty) return;

    final order = OrderItem(
      id: DateTime.now().toString(),
      products: _items.values.toList(),
      total: totalAmount,
      status: "Reviewing",
    );

    _orders.add(order);
    _items = {};

    saveCart();
    saveOrders();
    notifyListeners();

    Timer(const Duration(seconds: 10), () {
      order.status = "Received";
      saveOrders();
      notifyListeners();
    });
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();

    final data = _items.map(
      (key, value) => MapEntry(key.toString(), value.toJson()),
    );

    await prefs.setString('cart', jsonEncode(data));
  }

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('cart');
    if (data == null) return;

    final decoded = jsonDecode(data) as Map<String, dynamic>;

    _items = decoded.map(
      (key, value) => MapEntry(
        int.parse(key),
        CartItem.fromJson(value),
      ),
    );

    notifyListeners();
  }

  Future<void> saveOrders() async {
    final prefs = await SharedPreferences.getInstance();

    final data = _orders.map((e) => e.toJson()).toList();

    await prefs.setString('orders', jsonEncode(data));
  }

  Future<void> loadOrders() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString('orders');
    if (data == null) return;

    final decoded = jsonDecode(data) as List;

    _orders = decoded.map((e) => OrderItem.fromJson(e)).toList();

    notifyListeners();
  }
}
