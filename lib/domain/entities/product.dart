// lib/domain/entities/product.dart
import 'review.dart';

class Product {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final double price;
  final double rating;
  final String category;
  final List<Review> reviews;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.category,
    required this.reviews,
  });
}
