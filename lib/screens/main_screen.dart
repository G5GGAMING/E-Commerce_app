import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Product> products = [
    Product(
      id: 'p1',
      name: 'Bugatti Chiron',
      description: 'Luxury sport car',
      price: 145000.00,
      imageUrl: 'https://th.bing.com/th/id/OIP.pivDrkbzhuvSKa5yszkPqwHaHA?w=181&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
      category: 'Luxury',
    ),
    Product(
      id: 'p2',
      name: 'Lamborghini Aventador',
      description: 'High performance car',
      price: 500000.00,
      imageUrl: 'https://th.bing.com/th/id/OIP.navyMBCtcphHEX-AQVBLVQHaEK?w=281&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3',
      category: 'Sport',
    ),
  ];

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const CategoriesScreen();
      case 2:
        return const FavoritesScreen();
      case 3:
        return const CartScreen();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
          child: Text(
            'Cars',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
            ),
            itemBuilder: (ctx, i) => ProductCard(product: products[i]),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'E-Commerce App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            fontSize: 24,
            letterSpacing: 1,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 30),
                  onPressed: () => setState(() => _selectedIndex = 3),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blueAccent,
                    child: Text(
                      '${context.watch<CartProvider>().itemCount}',
                      style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF1E1E2C),
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey[600],
          showUnselectedLabels: true,
          selectedFontSize: 13,
          unselectedFontSize: 13,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Categories'),
            BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_rounded), label: 'Favorites'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: 'Cart'),
          ],
        ),
      ),
    );
  }
}
