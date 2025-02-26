import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/cart/cart_exports.dart';
import '../../models/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final cart = state.cart;
            if (cart == null || cart.isEmpty) {
              return const Center(
                child: Text(
                  "Your cart is empty",
                  style: TextStyle(fontSize: 18),
                ),
              );
            }

            final cartItems = cart.entries.toList();
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index].key;
                final quantity = cartItems[index].value;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    minTileHeight: 75.0,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        product.imageUrl,
                        width: 50,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "${product.price} ₽",
                      style: const TextStyle(color: Colors.green),
                    ),
                    trailing: _buildCounter(context, product, quantity),
                  ),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildCounter(BuildContext context, Product product, int quantity) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
            size: 20.0,
          ),
          onPressed: () {
            context.read<CartBloc>().add(DeleteFromCart(product));
          },
        ),
        Container(
          height: 36.0,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.remove,
                  color: Colors.red,
                  size: 20.0,
                ),
                onPressed: () {
                  context.read<CartBloc>().add(RemoveFromCart(product));
                },
              ),
              Text(
                "$quantity",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: const Icon(
                  Icons.add,
                  color: Colors.red,
                  size: 20.0,
                ),
                onPressed: () {
                  context.read<CartBloc>().add(AddToCart(product));
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
