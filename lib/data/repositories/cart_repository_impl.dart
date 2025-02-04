// lib/data/repositories/cart_repository_impl.dart
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final List<CartItem> _cartItems = [];

  @override
  Future<void> addToCart(CartItem item) async {
    // Check if product is already in cart; if so, update its quantity.
    final index = _cartItems.indexWhere((cartItem) => cartItem.product.id == item.product.id);
    if (index != -1) {
      _cartItems[index] = CartItem(
        product: item.product,
        quantity: _cartItems[index].quantity + item.quantity,
      );
    } else {
      _cartItems.add(item);
    }
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<List<CartItem>> getCartItems() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _cartItems;
  }

  @override
  Future<void> removeCartItem(int productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> updateCartItem(CartItem item) async {
    final index = _cartItems.indexWhere((cartItem) => cartItem.product.id == item.product.id);
    if (index != -1) {
      _cartItems[index] = item;
    }
    await Future.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
    await Future.delayed(const Duration(milliseconds: 200));
  }
}
