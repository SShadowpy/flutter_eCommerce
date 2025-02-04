// lib/presentation/pages/checkout_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/bloc/cart_bloc.dart';
import '../../presentation/bloc/cart_event.dart';
import '../../presentation/bloc/cart_state.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  double _calculateTotal(List cartItems) {
    double total = 0;
    for (var item in cartItems) {
      total += item.product.price * item.quantity;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded) {
            final items = state.items;
            if (items.isEmpty) {
              return const Center(child: Text("Your cart is empty."));
            }
            final total = _calculateTotal(items);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return ListTile(
                          title: Text(item.product.name),
                          subtitle: Text(
                              "${item.quantity} x \$${item.product.price.toStringAsFixed(2)}"),
                          trailing: Text(
                              "\$${(item.product.price * item.quantity).toStringAsFixed(2)}"),
                        );
                      },
                    ),
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text("Total"),
                    trailing: Text("\$${total.toStringAsFixed(2)}",
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Here you might integrate a payment gateway.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Checkout successful!")),
                      );
                      context.read<CartBloc>().add(ClearCartEvent());
                      Navigator.pop(context);
                    },
                    child: const Text("Confirm Checkout"),
                  ),
                ],
              ),
            );
          } else if (state is CartError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
