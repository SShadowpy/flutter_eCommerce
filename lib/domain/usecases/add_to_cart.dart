// lib/domain/usecases/add_to_cart.dart
import '../entities/cart_item.dart';
import '../repositories/cart_repository.dart';

class AddToCart {
  final CartRepository repository;
  AddToCart(this.repository);

  Future<void> call(CartItem item) async {
    await repository.addToCart(item);
  }
}
