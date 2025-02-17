// screens/second_screen.dart

import 'package:cart_app/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Second Screen')),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.selectedItems.length,
            itemBuilder: (context, index) {
              final item = state.selectedItems[index];
              return ListTile(
                title: Text(item.name),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Удаляем элемент из списка выбранных
                    BlocProvider.of<ProductListBloc>(context)
                        .add(RemoveFromCart(item));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
