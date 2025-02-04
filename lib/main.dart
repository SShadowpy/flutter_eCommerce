// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pj4/presentation/pages/splash_page.dart';
import 'data/repositories/product_repository_impl.dart';
import 'data/repositories/cart_repository_impl.dart';
import 'domain/usecases/get_products.dart';
import 'domain/usecases/search_products.dart';
import 'domain/usecases/add_to_cart.dart';
import 'domain/usecases/update_cart_item.dart';
import 'domain/usecases/remove_cart_item.dart';
import 'domain/usecases/clear_cart.dart';
import 'presentation/bloc/product_bloc.dart';
import 'presentation/bloc/cart_bloc.dart';
import 'presentation/pages/product_list_page.dart';
import 'presentation/pages/product_detail_page.dart';
import 'presentation/pages/cart_page.dart';
import 'presentation/pages/checkout_page.dart';

void main() {
  runApp(MyApp());
}
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
class MyApp extends StatelessWidget {
  MyApp({super.key});

  final productRepository = ProductRepositoryImpl();
  final cartRepository = CartRepositoryImpl();

  late final GetProducts getProducts = GetProducts(productRepository);
  late final SearchProducts searchProducts = SearchProducts(productRepository);

  late final AddToCart addToCart = AddToCart(cartRepository);
  late final UpdateCartItem updateCartItem = UpdateCartItem(cartRepository);
  late final RemoveCartItem removeCartItem = RemoveCartItem(cartRepository);
  late final ClearCart clearCart = ClearCart(cartRepository);

  late final GoRouter _router = GoRouter(
    observers: [routeObserver],
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const ProductListPage(),
        routes: [
          GoRoute(
            path: 'product/:id',
            builder: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
              return ProductDetailPage(productId: id);
            },
          ),
          GoRoute(
            path: 'cart',
            builder: (context, state) => const CartPage(),
          ),
          GoRoute(
            path: 'checkout',
            builder: (context, state) => const CheckoutPage(),
          ),
        ],
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductBloc>(
          create: (_) =>
              ProductBloc(getProducts: getProducts, searchProducts: searchProducts),
        ),
        BlocProvider<CartBloc>(
          create: (_) => CartBloc(
            repository: cartRepository,
            addToCart: addToCart,
            updateCartItem: updateCartItem,
            removeCartItem: removeCartItem,
            clearCart: clearCart,
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce App',
        routerConfig: _router,
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 1,
            iconTheme: IconThemeData(color: Colors.blueGrey.shade700),
            titleTextStyle: TextStyle(
              color: Colors.blueGrey.shade800,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blueGrey.shade700,
              shadowColor: Colors.black26,
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: Colors.grey.shade200,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
        ),
      ),
    );
  }
}
