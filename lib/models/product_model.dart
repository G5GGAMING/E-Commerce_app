class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final String category;

  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.category,
    this.isFavorite = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    String imageUrl = '';

    if (json['thumbnail'] != null) {
      imageUrl = json['thumbnail'].toString();
    } else if (json['images'] is List && (json['images'] as List).isNotEmpty) {
      imageUrl = (json['images'] as List).first.toString();
    }

    return Product(
      id: (json['id'] ?? 0) is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      title: (json['title'] ?? '').toString(),
      price: (json['price'] ?? 0).toDouble(),
      image: imageUrl,
      category: (json['category'] ?? '').toString().trim().toLowerCase(),
      isFavorite: json['isFavorite'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'category': category,
      'isFavorite': isFavorite,
    };
  }
}
