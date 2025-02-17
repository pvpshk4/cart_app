// screens/main_screen.dart

import 'package:cart_app/cart_screen.dart';
import 'package:cart_app/components/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductListBloc productListBloc =
        BlocProvider.of<ProductListBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Main Screen')),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: state.allItems.length,
            itemBuilder: (context, index) {
              final item = state.allItems[index];
              return ListTile(
                title: Text(item.name),
                trailing: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    // Добавляем элемент в список выбранных
                    productListBloc.add(AddToCart(item));
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(),
            ),
          );
        },
      ),
    );
  }
}
