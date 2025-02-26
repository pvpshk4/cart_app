import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Bloc/cart/cart_exports.dart';
import '../../Bloc/catalog/catalog_exports.dart';
import '../widgets/product_tile.dart';
import 'cart_screen.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog"),
      ),
      body: BlocBuilder<CatalogBloc, CatalogState>(
        builder: (context, state) {
          if (state is CatalogLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CatalogLoaded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.5,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];

                  return ProductTile(product: product);
                },
              ),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded && state.cart.isNotEmpty) {
            return FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartScreen()),
                );
              },
              child: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            )
                .animate()
                .fadeIn(duration: 400.ms)
                .scaleXY(begin: 0.5, end: 1.0, curve: Curves.easeOut);
          } else {
            return FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: () {},
              child: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            )
                .animate()
                .fadeOut(duration: 300.ms)
                .scaleXY(begin: 1.0, end: 0.5, curve: Curves.easeIn);
          }
        },
      ),
    );
  }
}
