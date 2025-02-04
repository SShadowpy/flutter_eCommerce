// lib/presentation/pages/product_detail_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../presentation/bloc/product_bloc.dart';
import '../../presentation/bloc/product_event.dart';
import '../../presentation/bloc/product_state.dart';
import '../../domain/entities/product.dart';
import '../../domain/entities/cart_item.dart';
import '../../presentation/bloc/cart_bloc.dart';
import '../../presentation/bloc/cart_event.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailPage extends StatelessWidget {
  final int productId;
  const ProductDetailPage({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dispatch event to load product detail.
    BlocProvider.of<ProductBloc>(context).add(SelectProduct(productId));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Detail"),
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProductDetailLoaded) {
            final Product product = state.product;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.network(
                        product.imageUrl,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.name,
                      style: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${product.price.toStringAsFixed(2)}",
                      style:
                          const TextStyle(fontSize: 20, color: Colors.green),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: product.rating,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 24.0,
                          direction: Axis.horizontal,
                        ),
                        const SizedBox(width: 8),
                        Text(product.rating.toString(),
                            style: const TextStyle(fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(product.description),
                    const SizedBox(height: 16),
                    const Text(
                      "Reviews",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...product.reviews.map((review) => ListTile(
                          title: Text(review.username),
                          subtitle: Text(review.comment),
                          trailing: Text(review.rating.toString()),
                        )),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Add product to cart with quantity 1.
                        final cartItem =
                            CartItem(product: product, quantity: 1);
                        context
                            .read<CartBloc>()
                            .add(AddItemToCart(cartItem));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Product added to cart")),
                        );
                      },
                      child: const Text("Add to Cart"),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is ProductError) {
            return Center(child: Text(state.message));
          }
          return Container();
        },
      ),
    );
  }
}
