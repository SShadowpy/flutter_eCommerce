// lib/domain/usecases/search_products.dart
import '../entities/product.dart';
import '../repositories/product_repository.dart';

class SearchProducts {
  final ProductRepository repository;
  SearchProducts(this.repository);

  Future<List<Product>> call({
    String? query,
    String? category,
    double? minPrice,
    double? maxPrice,
    double? minRating,
  }) async {
    return await repository.searchProducts(
      query: query,
      category: category,
      minPrice: minPrice,
      maxPrice: maxPrice,
      minRating: minRating,
    );
  }
}
