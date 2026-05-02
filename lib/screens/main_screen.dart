import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product_model.dart';
import '../providers/cart_provider.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';
import 'categories_screen.dart';
import 'favorites_screen.dart';

class PurchasesScreen extends StatelessWidget {
  const PurchasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: const Color(0xFF0F0F1E),
        appBar: AppBar(
          title: const Text('Order Tracking', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(
            indicatorColor: Colors.blueAccent,
            tabs: [Tab(text: "Reviewing"), Tab(text: "Received"), Tab(text: "Cancelled")],
          ),
        ),
        body: TabBarView(
          children: [
            _buildOrderList(cart.orders.where((o) => o.status == "Reviewing").toList()),
            _buildOrderList(cart.orders.where((o) => o.status == "Received").toList()),
            const Center(child: Text("No cancelled orders", style: TextStyle(color: Colors.grey))),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(List<OrderItem> orders) {
    if (orders.isEmpty) return const Center(child: Text("List is empty", style: TextStyle(color: Colors.grey)));
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: orders.length,
      itemBuilder: (ctx, i) {
        final order = orders[i];
        return Column(
          children: order.products.map((item) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(color: const Color(0xFF1E1E2C), borderRadius: BorderRadius.circular(15)),
            child: ListTile(
              leading: ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(item.product.imageUrl, width: 45, height: 45, fit: BoxFit.cover)),
              title: Text(item.product.name, style: const TextStyle(color: Colors.white, fontSize: 14)),
              subtitle: Text("Status: ${order.status}", style: const TextStyle(color: Colors.blueAccent, fontSize: 12)),
              trailing: Icon(order.status == "Received" ? Icons.verified : Icons.hourglass_bottom, color: order.status == "Received" ? Colors.green : Colors.orange),
            ),
          )).toList(),
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static final List<Product> productsList = [

    Product(id: 'e1', name: 'iPhone 15 Pro', description: 'Titanium, A17 Pro chip', price: 999.0, imageUrl: 'https://th.bing.com/th/id/OIP.42oCqFckm36xlOq99EPpBwHaE7?w=267&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Electronics'),
    Product(id: 'e2', name: 'MacBook Air M3', description: '13-inch Liquid Retina display', price: 1099.0, imageUrl: 'https://th.bing.com/th/id/OIP.QJYIxFXDqJt-p4tQYsrWfQHaEK?w=289&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Electronics'),
    Product(id: 'e3', name: 'Sony WH-1000XM5', description: 'Noise Canceling Headphones', price: 399.0, imageUrl: 'https://th.bing.com/th/id/OIP.OyDkaG1nOKJv--fWEMAriAHaEw?w=310&h=199&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Electronics'),
    Product(id: 'e4', name: 'Samsung S24 Ultra', description: '200MP Camera, AI features', price: 1299.0, imageUrl: 'https://th.bing.com/th/id/OIP.RCaOvi3C_QXx33EUvGht9wHaFj?w=247&h=185&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Electronics'),
    Product(id: 'e5', name: 'iPad Pro M2', description: '12.9-inch mini-LED display', price: 1099.0, imageUrl: 'https://th.bing.com/th/id/OIP.zKmreiy52MxeK47V6VIx4QHaE7?w=229&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Electronics'),
    Product(id: 'e6', name: 'Apple Watch Ultra 2', description: 'Rugged and capable watch', price: 799.0, imageUrl: 'https://th.bing.com/th/id/OIP.x04tqM0fDN1v5EShiw5vZgHaHa?w=89&h=89&c=1&rs=1&qlt=70&r=0&o=7&dpr=1.3&pid=InlineBlock&rm=3', category: 'Electronics'),
    Product(id: 'e7', name: 'Dell XPS 15', description: 'OLED Display, i9 Processor', price: 1899.0, imageUrl: 'https://th.bing.com/th/id/OIP.W8UMLRZmJh5-qd9Y5OyM9QHaEL?w=293&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Electronics'),
    Product(id: 'e8', name: 'Nintendo Switch', description: 'OLED Model, Neon Blue/Red', price: 349.0, imageUrl: 'https://th.bing.com/th/id/OIP.cYo6lyyGgOYEynDYcdNsBQHaD_?w=277&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Electronics'),
    Product(id: 'e9', name: 'GoPro Hero 12', description: '5.3K Video, Waterproof', price: 399.0, imageUrl: 'https://th.bing.com/th/id/OIP.FC-C_sV0GsmkujivM3TT8wHaEK?w=333&h=187&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Electronics'),
    Product(id: 'e10', name: 'PlayStation 5', description: 'Ultra-High Speed SSD', price: 499.0, imageUrl: 'https://th.bing.com/th/id/OIP.7wOjlmLhie5d2ABpILDZhAHaD1?w=321&h=179&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Electronics'),

    Product(id: 'f1', name: 'Leather Jacket', description: 'Classic black biker jacket', price: 120.0, imageUrl: 'https://th.bing.com/th/id/OIP.kYpbd2XOGsd8spTPpm2vHwHaHa?w=208&h=208&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Fashion'),
    Product(id: 'f2', name: 'Denim Jeans', description: 'Slim fit blue denim', price: 55.0, imageUrl: 'https://th.bing.com/th/id/OIP.moFWOR8imppAoArqTnfeaAHaHa?w=208&h=208&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Fashion'),
    Product(id: 'f3', name: 'Wool Coat', description: 'Elegant beige winter coat', price: 210.0, imageUrl: 'https://th.bing.com/th/id/OIP.GATnZXhx54alXfTRvx0DpgHaHa?w=208&h=208&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Fashion'),
    Product(id: 'f5', name: 'Luxury Handbag', description: 'Premium leather shoulder bag', price: 450.0, imageUrl: 'https://th.bing.com/th/id/OIP.bgVoNlcViEoyMwLGjmwPzgHaHa?w=187&h=187&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Fashion'),
    Product(id: 'f6', name: 'Silk Scarf', description: 'Pure silk with abstract patterns', price: 35.0, imageUrl: 'https://th.bing.com/th/id/OIP.nPdWqOvIlj-cLPU0x_t-FgHaHa?w=185&h=185&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Fashion'),
    Product(id: 'f7', name: 'White Sneakers', description: 'Classic minimal urban style', price: 85.0, imageUrl: 'https://th.bing.com/th/id/OIP.ziLv6L8QHT5o1W4ZO94HygHaFj?w=244&h=184&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Fashion'),
    Product(id: 'f8', name: 'Men’s Suit', description: 'Navy blue formal 3-piece', price: 320.0, imageUrl: 'https://th.bing.com/th/id/OIP.YSbesCe7K56wIoCsF3jrLwHaLP?w=202&h=308&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Fashion'),
    Product(id: 'f9', name: 'Cotton T-Shirt', description: 'Essential plain white tee', price: 15.0, imageUrl: 'https://th.bing.com/th/id/OIP.OFJc3pGUGzSVpvQp4a6uQQHaHa?w=211&h=211&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Fashion'),
    Product(id: 'f10', name: 'Polarized Sunglasses', description: 'Retro design with UV protection', price: 110.0, imageUrl: 'https://th.bing.com/th/id/OIP.QQEhhng55wdZwQB7aRUKMAHaHa?w=141&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Fashion'),

    Product(id: 's1', name: 'Yoga Mat', description: 'Non-slip eco-friendly mat', price: 25.0, imageUrl: 'https://th.bing.com/th/id/OIP.uiUaVvXHgMrSgS_8fJ8OJQHaGR?w=205&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Sports'),
    Product(id: 's2', name: 'Dumbbell Set', description: 'Adjustable home weight set', price: 140.0, imageUrl: 'https://th.bing.com/th/id/OIP.4EKJzEoei_fg7ewQt2lA1gHaFI?w=288&h=200&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Sports'),
    Product(id: 's3', name: 'Basketball Ball', description: 'Official size and weight', price: 30.0, imageUrl: 'https://th.bing.com/th/id/OIP.7ZR-t92OP_HsreWxWlOeIgHaHa?w=137&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Sports'),
    Product(id: 's4', name: 'Running Shoes', description: 'High-performance foam sole', price: 130.0, imageUrl: 'https://th.bing.com/th/id/OIP.Y3qsF8IpXnGNV5lzzKh_9gHaEK?w=294&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Sports'),
    Product(id: 's5', name: 'Tennis Racket', description: 'Lightweight graphite frame', price: 195.0, imageUrl: 'https://th.bing.com/th/id/OIP.qG_q9DocJOf6W4wCLZwcCwHaE8?w=264&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Sports'),
    Product(id: 's6', name: 'Smart Treadmill', description: 'Foldable with LCD screen', price: 850.0, imageUrl: 'https://th.bing.com/th/id/OIP.mvKqLgtZAVU5xHeleFCIXgHaE8?w=238&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Sports'),
    Product(id: 's7', name: 'Cycling Helmet', description: 'Aerodynamic safety helmet', price: 65.0, imageUrl: 'https://th.bing.com/th/id/OIP.KUAJoZznrSZ11BNjSxk-LwHaE8?w=276&h=184&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Sports'),
    Product(id: 's8', name: 'Swimming Goggles', description: 'Anti-fog and UV protection', price: 20.0, imageUrl: 'https://th.bing.com/th/id/OIP.VQ7acBrPTiiupcdwJ1E0LwHaE8?w=297&h=199&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Sports'),
    Product(id: 's9', name: 'Gym Duffel Bag', description: 'Waterproof with shoe compartment', price: 45.0, imageUrl: 'https://th.bing.com/th/id/OIP.BADpxW6YOKRR4fzLHmtOFAHaFa?w=281&h=204&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Sports'),
    Product(id: 's10', name: 'Punching Bag', description: 'Heavy duty leather bag', price: 180.0, imageUrl: 'https://th.bing.com/th/id/OIP.7Z396X0nUJhKaulg3zjKRwHaHa?w=216&h=216&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Sports'),

    Product(id: 'p1', name: 'Dior Sauvage', description: 'Raw and noble fresh scent', price: 120.0, imageUrl: 'https://th.bing.com/th/id/OIP.mVLeQwHGCp_Z95XJKf6FIwHaIQ?w=185&h=207&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Perfumes'),
    Product(id: 'p2', name: 'Chanel No. 5', description: 'Iconic floral fragrance', price: 155.0, imageUrl: 'https://th.bing.com/th/id/OIP.OOSBUn2f9vTV1Dkw1TikdAHaEW?w=311&h=182&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Perfumes'),
    Product(id: 'p3', name: 'Blue de Chanel', description: 'Woody and aromatic for men', price: 115.0, imageUrl: 'https://th.bing.com/th/id/OIP.4yBcI0VvEFVWP7vzaxHasAHaHa?w=210&h=210&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Perfumes'),
    Product(id: 'p4', name: 'Versace Eros', description: 'Mint, apple and vanilla notes', price: 95.0, imageUrl: 'https://th.bing.com/th/id/OIP.M-izCcpjIcmZ2yM2nHWh3wHaGS?w=212&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Perfumes'),
    Product(id: 'p5', name: 'Tom Ford Black Orchid', description: 'Luxurious and sensual scent', price: 185.0, imageUrl: 'https://th.bing.com/th/id/OIP.4eiVaTKPbdEiOcnMyNb7lgHaHa?w=205&h=205&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Perfumes'),
    Product(id: 'p6', name: 'Gucci Bloom', description: 'White floral bouquet', price: 130.0, imageUrl: 'https://th.bing.com/th/id/OIP.XlOVOepJzrD1lYKhjxWN6AHaHa?w=220&h=220&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Perfumes'),
    Product(id: 'p7', name: 'YSL Libre', description: 'Lavender and orange blossom', price: 140.0, imageUrl: 'https://th.bing.com/th/id/OIP.TmnJV7fdTbzkDvt62liU7gHaHa?w=188&h=188&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Perfumes'),
    Product(id: 'p8', name: 'Giorgio Armani Si', description: 'Chic and feminine nectar', price: 125.0, imageUrl: 'https://th.bing.com/th/id/OIP.eq4S5azIVT-lrOPuBkTbJwHaHa?w=209&h=209&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Perfumes'),
    Product(id: 'p9', name: 'Jo Malone London', description: 'Wood Sage and Sea Salt', price: 160.0, imageUrl: 'https://th.bing.com/th/id/OIP.TXUbRsvrQa8U9cmLYSzSkAHaC_?w=323&h=141&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Perfumes'),
    Product(id: 'p10', name: 'Paco Rabanne 1 Million', description: 'Spicy leather and gold', price: 105.0, imageUrl: 'https://th.bing.com/th/id/OIP.YG_RxqLHtzcj0NR7zrAXhAHaHt?w=201&h=210&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Perfumes'),

    Product(id: 'fu1', name: 'Modern Sofa', description: '3-seater velvet grey sofa', price: 899.0, imageUrl: 'https://th.bing.com/th/id/OIP.TaqRTR-ke_oJA6gWovYMPgHaHa?w=202&h=203&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Furniture'),
    Product(id: 'fu2', name: 'Dining Table', description: 'Solid oak wood for 6 people', price: 650.0, imageUrl: 'https://th.bing.com/th/id/OIP.xuhVe6WCMBDA9IuCQQUJSwHaHa?w=211&h=211&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Furniture'),
    Product(id: 'fu3', name: 'Office Chair', description: 'Ergonomic with lumbar support', price: 240.0, imageUrl: 'https://th.bing.com/th/id/OIP.Am1KmuKwkVLXK5uNKMBG5AHaHa?w=219&h=220&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Furniture'),
    Product(id: 'fu4', name: 'Queen Size Bed', description: 'Luxury frame with headboard', price: 1200.0, imageUrl: 'https://th.bing.com/th/id/OIP.nt5A2m6JcVo_hZ2RdNpIFwHaHa?w=214&h=214&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Furniture'),
    Product(id: 'fu5', name: 'Bookshelf', description: 'Minimalist 5-tier metal shelf', price: 150.0, imageUrl: 'https://th.bing.com/th/id/OIP.2M0K5nimQrJmmX0vqoq4hwHaLH?w=204&h=306&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Furniture'),
    Product(id: 'fu6', name: 'Coffee Table', description: 'Marble top with gold legs', price: 320.0, imageUrl: 'https://th.bing.com/th/id/OIP.C3sAWDm2mYHrt2tapCcY7wHaHa?w=199&h=199&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Furniture'),
    Product(id: 'fu7', name: 'Wardrobe', description: 'Large 3-door with mirror', price: 950.0, imageUrl: 'https://th.bing.com/th/id/OIP.2_detqPkfH9RTQnIcGT2MwHaHa?w=175&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Furniture'),
    Product(id: 'fu8', name: 'Nightstand', description: 'Wooden with 2 drawers', price: 85.0, imageUrl: 'https://th.bing.com/th/id/OIP.LHrATNmOUAFFqK7zAZpGSQHaHa?w=220&h=220&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Furniture'),
    Product(id: 'fu9', name: 'Floor Lamp', description: 'Modern LED arched lamp', price: 110.0, imageUrl: 'https://th.bing.com/th/id/OIP.WhSYmsxnGrgnrnZDPHzgzAHaHa?w=210&h=210&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Furniture'),
    Product(id: 'fu10', name: 'Outdoor Lounge', description: 'Weather-proof rattan set', price: 540.0, imageUrl: 'https://th.bing.com/th/id/OIP.mfzB5-hiD2YTkbTspe7lGAHaIB?w=152&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Furniture'),

    Product(id: 'o1', name: 'Hardcover Notebook', description: 'Premium paper for sketching', price: 18.0, imageUrl: 'https://th.bing.com/th/id/OIP.CXPQ-XJdzACdwVOuBt1rkQHaHQ?w=199&h=195&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Others'),
    Product(id: 'o2', name: 'Travel Pillow', description: 'Memory foam neck support', price: 22.0, imageUrl: 'https://th.bing.com/th/id/OIP.gBRv7b5q3_khJ0ktnfxl-wHaHa?w=195&h=196&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Others'),
    Product(id: 'o3', name: 'Coffee Mug Set', description: '4 ceramic matte mugs', price: 30.0, imageUrl: 'https://th.bing.com/th/id/OIP.Z4GrOnuVdS1yPcE2GidwugHaHa?w=220&h=220&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Others'),
    Product(id: 'o4', name: 'Wall Clock', description: 'Silent non-ticking quartz', price: 40.0, imageUrl: 'https://th.bing.com/th/id/OIP.bSIEFq36MAFXgDmN4z3g5wHaHa?w=220&h=220&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Others'),
    Product(id: 'o5', name: 'Electric Kettle', description: 'Stainless steel fast boiling', price: 55.0, imageUrl: 'https://th.bing.com/th/id/OIP.CYPva8rL5B-FIh8GhMhwYwHaHa?w=191&h=191&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Others'),
    Product(id: 'o6', name: 'Scented Candle', description: 'Lavender and vanilla soy wax', price: 15.0, imageUrl: 'https://th.bing.com/th/id/OIP.EAad7NP9C6OB7reszuyruAHaEK?w=304&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Others'),
    Product(id: 'o7', name: 'Board Game Set', description: 'Classic chess and backgammon', price: 65.0, imageUrl: 'https://th.bing.com/th/id/OIP.8LA4D9dwXjm4NtBKE9J4FgHaHK?w=157&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Others'),
    Product(id: 'o8', name: 'Water Bottle', description: 'Insulated stainless steel 1L', price: 25.0, imageUrl: 'https://th.bing.com/th/id/OIP.uCALBTknmCUSJXaZr-m22gHaHa?w=213&h=213&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Others'),
    Product(id: 'o9', name: 'Desk Organizer', description: 'Wood and metal stationery holder', price: 35.0, imageUrl: 'https://th.bing.com/th/id/OIP.wPdfbP64EMdVbuggfcfFogHaHa?w=206&h=206&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Others'),
    Product(id: 'o10', name: 'Umbrella', description: 'Windproof automatic opening', price: 20.0, imageUrl: 'https://th.bing.com/th/id/OIP.MsG9DunyvXaRE62EOktpqQHaFE?w=262&h=180&c=7&r=0&o=7&dpr=1.3&pid=1.7&rm=3', category: 'Others'),
  ];

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  String? _selectedCategory;

  Widget _buildBody() {
    if (_selectedIndex == 1 && _selectedCategory != null) {
      return _buildCategoryItemsContent();
    }

    switch (_selectedIndex) {
      case 0: return _buildHomeContent();
      case 1: return CategoriesScreen(
        onCategoryTap: (categoryName) {
          setState(() => _selectedCategory = categoryName);
        },
      ); 
      case 2: return const FavoritesScreen();
      case 3: return const CartScreen();
      default: return _buildHomeContent();
    }
  }

  Widget _buildCategoryItemsContent() {
    final categoryItems = MainScreen.productsList
        .where((p) => p.category == _selectedCategory)
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                onPressed: () => setState(() => _selectedCategory = null),
              ),
              Text(
                '$_selectedCategory Items',
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Expanded(
          child: categoryItems.isEmpty
              ? const Center(child: Text("No items in this category", style: TextStyle(color: Colors.grey)))
              : GridView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: categoryItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    childAspectRatio: 0.75, 
                    crossAxisSpacing: 15, 
                    mainAxisSpacing: 15
                  ),
                  itemBuilder: (ctx, i) => ProductCard(product: categoryItems[i]),
                ),
        ),
      ],
    );
  }

  Widget _buildHomeContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25), 
          child: Text('ALL', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: Colors.white))
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15), 
            itemCount: MainScreen.productsList.length, 
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, 
              childAspectRatio: 0.75, 
              crossAxisSpacing: 15, 
              mainAxisSpacing: 15
            ), 
            itemBuilder: (ctx, i) => ProductCard(product: MainScreen.productsList[i])
          )
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
        title: const Text('E-Commerce App', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 24)),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_bag_outlined, color: Colors.white, size: 30), 
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const PurchasesScreen()))
          ),
        ],
      ),
      body: _buildBody(), 
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.4), blurRadius: 20)],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
              _selectedCategory = null; 
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color(0xFF1E1E2C),
          selectedItemColor: Colors.blueAccent,
          unselectedItemColor: Colors.grey,
          items: [
            const BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            const BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Categories'),
            const BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_rounded), label: 'Favorites'),
            BottomNavigationBarItem(
              icon: Stack(children: [
                const Icon(Icons.shopping_cart_outlined), 
                if (context.watch<CartProvider>().itemCount > 0) 
                  Positioned(
                    right: 0, 
                    child: CircleAvatar(
                      radius: 7, 
                      backgroundColor: Colors.redAccent, 
                      child: Text('${context.watch<CartProvider>().itemCount}', style: const TextStyle(fontSize: 8, color: Colors.white))
                    )
                  )
              ]), 
              label: 'Cart'
            ),
          ],
        ),
      ),
    );
  }
}