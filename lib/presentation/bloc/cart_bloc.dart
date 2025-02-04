// lib/presentation/bloc/cart_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_to_cart.dart';
import '../../domain/usecases/update_cart_item.dart';
import '../../domain/usecases/remove_cart_item.dart';
import '../../domain/usecases/clear_cart.dart';
import '../../domain/repositories/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository repository;
  final AddToCart addToCart;
  final UpdateCartItem updateCartItem;
  final RemoveCartItem removeCartItem;
  final ClearCart clearCart;

  CartBloc({
    required this.repository,
    required this.addToCart,
    required this.updateCartItem,
    required this.removeCartItem,
    required this.clearCart,
  }) : super(CartInitial()) {
    on<LoadCart>(_onLoadCart);
    on<AddItemToCart>(_onAddItemToCart);
    on<UpdateCart>(_onUpdateCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      final items = await repository.getCartItems();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError("Failed to load cart."));
    }
  }

  Future<void> _onAddItemToCart(
      AddItemToCart event, Emitter<CartState> emit) async {
    try {
      await addToCart(event.item);
      final items = await repository.getCartItems();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError("Failed to add item."));
    }
  }

  Future<void> _onUpdateCart(
      UpdateCart event, Emitter<CartState> emit) async {
    try {
      await updateCartItem(event.item);
      final items = await repository.getCartItems();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError("Failed to update item."));
    }
  }

  Future<void> _onRemoveItemFromCart(
      RemoveItemFromCart event, Emitter<CartState> emit) async {
    try {
      await removeCartItem(event.productId);
      final items = await repository.getCartItems();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError("Failed to remove item."));
    }
  }

  Future<void> _onClearCart(
      ClearCartEvent event, Emitter<CartState> emit) async {
    try {
      await clearCart();
      final items = await repository.getCartItems();
      emit(CartLoaded(items));
    } catch (e) {
      emit(CartError("Failed to clear cart."));
    }
  }
}
