import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../widgets/product_card.dart';
class CategoryProductsScreen extends StatelessWidget {
  final String categoryTitle;
  final List<Product> allProducts;
  const CategoryProductsScreen({
    super.key, 
    required this.categoryTitle, 
    required this.allProducts
  });
  @override
  Widget build(BuildContext context) {
    final categoryItems = allProducts.where((p) => p.category == categoryTitle).toList();
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        title: Text('$categoryTitle Items'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: categoryItems.isEmpty
          ? const Center(child: Text("No items found in this category", style: TextStyle(color: Colors.grey)))
          : GridView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: categoryItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (ctx, i) => ProductCard(product: categoryItems[i]),
            ),
    );
  }
}
