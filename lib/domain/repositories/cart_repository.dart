// lib/domain/repositories/cart_repository.dart
import '../entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCartItems();
  Future<void> addToCart(CartItem item);
  Future<void> updateCartItem(CartItem item);
  Future<void> removeCartItem(int productId);
  Future<void> clearCart();
}
