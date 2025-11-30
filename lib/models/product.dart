// lib/models/product.dart
class Product {
  final String id;
  final String name;
  final String brand;
  final String category;
  final int price;
  final double rating;
  final String image;
  final String short;
  final String description;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.price,
    required this.rating,
    required this.image,
    required this.short,
    required this.description,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"].toString(),
      name: json["name"] ?? '',
      brand: json["brand"] ?? '',
      category: json["category"] ?? '',
      price: (json["price"] ?? 0) is int ? json["price"] as int : int.tryParse(json["price"].toString()) ?? 0,
      rating: (json["rating"] ?? 0).toDouble(),
      image: json["image"] ?? '',
      short: json["short"] ?? '',
      description: json["description"] ?? '',
    );
  }
}
