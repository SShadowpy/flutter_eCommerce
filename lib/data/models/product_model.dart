// lib/data/models/product_model.dart
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';

class ProductModel extends Product {
  ProductModel({
    required int id,
    required String name,
    required String description,
    required String imageUrl,
    required double price,
    required double rating,
    required String category,
    required List<Review> reviews,
  }) : super(
          id: id,
          name: name,
          description: description,
          imageUrl: imageUrl,
          price: price,
          rating: rating,
          category: category,
          reviews: reviews,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      category: json['category'],
      reviews: (json['reviews'] as List<dynamic>).map((review) => Review(
        username: review['username'],
        comment: review['comment'],
        rating: (review['rating'] as num).toDouble(),
      )).toList(),
    );
  }
  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'rating': rating,
      'category': category,
      'reviews': reviews.map((r) => {
        'username': r.username,
        'comment': r.comment,
        'rating': r.rating,
      }).toList(),
    };
  }
}
