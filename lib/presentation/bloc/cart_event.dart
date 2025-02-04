// lib/presentation/bloc/cart_event.dart
import '../../domain/entities/cart_item.dart';

abstract class CartEvent {}

class LoadCart extends CartEvent {}

class AddItemToCart extends CartEvent {
  final CartItem item;
  AddItemToCart(this.item);
}

class UpdateCart extends CartEvent {
  final CartItem item;
  UpdateCart(this.item);
}

class RemoveItemFromCart extends CartEvent {
  final int productId;
  RemoveItemFromCart(this.productId);
}

class ClearCartEvent extends CartEvent {}
