// lib/presentation/bloc/product_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_products.dart';
import '../../domain/usecases/search_products.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final SearchProducts searchProducts;

  ProductBloc({
    required this.getProducts,
    required this.searchProducts,
  }) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<SearchProductsEvent>(_onSearchProducts);
    on<SelectProduct>(_onSelectProduct);
  }

  Future<void> _onLoadProducts(
      LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await getProducts();
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError("Failed to load products."));
    }
  }

  Future<void> _onSearchProducts(
      SearchProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await searchProducts(
        query: event.query,
        category: event.category,
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
        minRating: event.minRating,
      );
      emit(ProductsLoaded(products));
    } catch (e) {
      emit(ProductError("Search failed."));
    }
  }

  Future<void> _onSelectProduct(
      SelectProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      // For simplicity, reusing getProducts() to find the product by ID.
      final products = await getProducts();
      final product = products.firstWhere((p) => p.id == event.productId);
      emit(ProductDetailLoaded(product));
    } catch (e) {
      emit(ProductError("Failed to load product detail."));
    }
  }
}
