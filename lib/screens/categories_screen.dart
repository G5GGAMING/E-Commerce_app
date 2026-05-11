import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  final Function(String) onCategoryTap;

  const CategoriesScreen({
    super.key,
    required this.onCategoryTap,
  });

  static const List<Map<String, dynamic>> categories = [
    {
      'title': 'beauty',
      'icon': Icons.spa,
      'color': Colors.pinkAccent,
    },
    {
      'title': 'fragrances',
      'icon': Icons.sanitizer,
      'color': Colors.purpleAccent,
    },
    {
      'title': 'furniture',
      'icon': Icons.chair,
      'color': Colors.orangeAccent,
    },
    {
      'title': 'groceries',
      'icon': Icons.local_grocery_store,
      'color': Colors.greenAccent,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.1,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
          ),
          itemBuilder: (ctx, i) {
            final category = categories[i];

            return InkWell(
              onTap: () => onCategoryTap(category['title']),
              borderRadius: BorderRadius.circular(25),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2C),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: (category['color'] as Color).withOpacity(0.2),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: (category['color'] as Color).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        category['icon'],
                        size: 38,
                        color: category['color'],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      category['title'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
