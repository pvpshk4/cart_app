import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_bloc.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final cartItems = state.cart.entries.toList();
            if (cartItems.isEmpty) {
              return Center(
                child:
                    Text("Your cart is empty", style: TextStyle(fontSize: 18)),
              );
            }

            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index].key;
                final quantity = cartItems[index].value;

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: ListTile(
                    minTileHeight: 75.0,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(product.imageUrl,
                          width: 50, height: 60, fit: BoxFit.cover),
                    ),
                    title: Text(product.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${product.price} ₽",
                        style: TextStyle(color: Colors.green)),
                    trailing: _buildCounter(context, product, quantity),
                  ),
                );
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildCounter(BuildContext context, Product product, int quantity) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          padding: EdgeInsets.all(0.0),
          icon: Icon(
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
                padding: EdgeInsets.all(0.0),
                icon: Icon(
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
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              IconButton(
                padding: EdgeInsets.all(0.0),
                icon: Icon(
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
