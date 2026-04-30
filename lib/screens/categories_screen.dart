import 'package:flutter/material.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  static const List<Map<String, dynamic>> categories = [
    {'title': 'Electronics', 'icon': Icons.electrical_services_rounded, 'color': Colors.blueAccent},
    {'title': 'Fashion', 'icon': Icons.checkroom_rounded, 'color': Colors.pinkAccent},
    {'title': 'Sports', 'icon': Icons.sports_basketball_rounded, 'color': Colors.orangeAccent},
    {'title': 'Perfumes', 'icon': Icons.auto_awesome_rounded, 'color': Colors.purpleAccent},
    {'title': 'Furniture', 'icon': Icons.chair_rounded, 'color': Colors.tealAccent},
    {'title': 'Others', 'icon': Icons.more_horiz_rounded, 'color': Colors.blueGrey},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        title: const Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24, color: Colors.white),
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
          itemBuilder: (ctx, i) => InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(25),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1E2C),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: (categories[i]['color'] as Color).withOpacity(0.2),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (categories[i]['color'] as Color).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      categories[i]['icon'] as IconData,
                      size: 38,
                      color: categories[i]['color'] as Color,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    categories[i]['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
