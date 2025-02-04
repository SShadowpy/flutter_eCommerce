// lib/domain/usecases/remove_cart_item.dart
import '../repositories/cart_repository.dart';

class RemoveCartItem {
  final CartRepository repository;
  RemoveCartItem(this.repository);

  Future<void> call(int productId) async {
    await repository.removeCartItem(productId);
  }
}
