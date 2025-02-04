// lib/presentation/bloc/product_event.dart
abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}

class SearchProductsEvent extends ProductEvent {
  final String query;
  final String? category;
  final double? minPrice;
  final double? maxPrice;
  final double? minRating;

  SearchProductsEvent({
    required this.query,
    this.category,
    this.minPrice,
    this.maxPrice,
    this.minRating,
  });
}

class SelectProduct extends ProductEvent {
  final int productId;
  SelectProduct(this.productId);
}
