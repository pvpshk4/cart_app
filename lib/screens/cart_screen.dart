import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart_bloc.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Корзина")),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartUpdated) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final CartItem item = state.items[index];

                return ListTile(
                  leading: Image.network(item.product.imageUrl, width: 50),
                  title: Text(item.product.name),
                  subtitle: Text("${item.product.price} ₽ x${item.quantity}"),
                  trailing: IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      context
                          .read<CartBloc>()
                          .add(RemoveFromCart(item.product));
                    },
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
