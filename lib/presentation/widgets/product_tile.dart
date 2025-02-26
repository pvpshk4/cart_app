import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/cart/cart_exports.dart';
import '../../models/product.dart';

class ProductTile extends StatelessWidget {
  final Product product;

  const ProductTile({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${product.price} ₽",
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
                BlocBuilder<CartBloc, CartState>(
                  builder: (context, state) {
                    final quantity = state.cart?[product] ?? 0;
                    final isCounter = quantity > 0;

                    return SizedBox(
                      height: 40,
                      child: AnimatedSwitcher(
                        duration: 300.ms,
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0),
                              end: const Offset(0, 0),
                            ).animate(animation),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                        child: isCounter
                            ? _CounterWidget(
                                key: const ValueKey('counter'),
                                product: product,
                                quantity: quantity,
                              )
                            : _AddButton(
                                key: const ValueKey('add_button'),
                                product: product,
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final Product product;
  const _AddButton({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(8),
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.add_shopping_cart,
              size: 18, color: Colors.black),
          onPressed: () => context.read<CartBloc>().add(AddToCart(product)),
        ),
      )
          .animate()
          .fadeIn(duration: 200.ms)
          .scaleXY(begin: 0.5, end: 1, curve: Curves.easeOutBack),
    );
  }
}

class _CounterWidget extends StatelessWidget {
  final Product product;
  final int quantity;
  const _CounterWidget({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        height: 36,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red, size: 20),
              onPressed: () =>
                  context.read<CartBloc>().add(DeleteFromCart(product)),
            ),
            Container(
              height: 36,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.remove, color: Colors.red, size: 20),
                    onPressed: () =>
                        context.read<CartBloc>().add(RemoveFromCart(product)),
                  ),
                  Text(
                    '$quantity',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.add, color: Colors.red, size: 20),
                    onPressed: () =>
                        context.read<CartBloc>().add(AddToCart(product)),
                  ),
                ],
              ),
            ),
          ],
        ),
      )
          .animate(key: key)
          .fadeIn(duration: 200.ms)
          .scaleXY(begin: 0.8, end: 1, curve: Curves.easeOutBack),
    );
  }
}
