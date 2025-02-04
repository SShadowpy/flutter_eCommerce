// lib/data/repositories/product_repository_impl.dart
import '../../domain/entities/product.dart';
import '../../domain/entities/review.dart';
import '../../domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  // Simulated in‑memory list of products.
  final List<Product> _products = [
    Product(
      id: 1,
      name: "Smartphone",
      description: "Latest smartphone with high performance and advanced camera.",
      imageUrl: "https://m.media-amazon.com/images/I/71a6r1S8pxL.jpg",
      price: 699.99,
      rating: 4.5,
      category: "Electronics",
      reviews: [
        Review(username: "Isaias", comment: "Amazing phone!", rating: 5.0),
        Review(username: "Alan", comment: "Good value for money.", rating: 4.0),
      ],
    ),
    Product(
      id: 2,
      name: "Running Shoes",
      description: "Comfortable and durable shoes designed for running.",
      imageUrl: "https://cdn.thewirecutter.com/wp-content/media/2024/11/runningshoes-2048px-09522.jpg?auto=webp&quality=75&width=1024",
      price: 89.99,
      rating: 4.2,
      category: "Sports",
      reviews: [
        Review(username: "Charlie", comment: "Very comfortable.", rating: 4.5),
      ],
    ),
    Product(
      id: 3,
      name: "Toy Car",
      description: "Funny toy to play with",
      imageUrl: "https://sunrise-theme.myshopify.com/cdn/shop/products/5_900x.jpg?v=1334936803",
      price: 29.99,
      rating: 1.0,
      category: "Home",
      reviews: [
        Review(username: "Ruben", comment: "Very ugly.", rating: 1.0),
      ],
    ),
      Product(
        id: 4,
        name: "Gaming Laptop",
        description: "Powerful device",
        imageUrl: "https://www.hp.com/es-es/shop/Html/Merch/Images/c08502143_1750x1285.jpg",
        price: 899.99,
        rating: 5.0,
        category: "Sports",
        reviews: [
          Review(username: "Chris", comment: "Very POWERFUL.", rating: 5.0),
        ],
      ),
  ];

  @override
  Future<List<Product>> getProducts() async {
    // Simulate network delay.
    await Future.delayed(const Duration(milliseconds: 500));
    return _products;
  }

  @override
  Future<Product> getProductById(int id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _products.firstWhere((product) => product.id == id);
  }

  @override
  Future<List<Product>> searchProducts({
    String? query,
    String? category,
    double? minPrice,
    double? maxPrice,
    double? minRating,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _products.where((product) {
      bool matches = true;
      if (query != null && query.isNotEmpty) {
        matches &= product.name.toLowerCase().contains(query.toLowerCase());
      }
      if (category != null && category.isNotEmpty) {
        matches &= product.category.toLowerCase() == category.toLowerCase();
      }
      if (minPrice != null) {
        matches &= product.price >= minPrice;
      }
      if (maxPrice != null) {
        matches &= product.price <= maxPrice;
      }
      if (minRating != null) {
        matches &= product.rating >= minRating;
      }
      return matches;
    }).toList();
  }
}
