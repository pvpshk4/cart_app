import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/product.dart';
import '../Bloc/cart/cart_exports.dart';

class CounterWidget extends StatelessWidget {
  final Product product;
  final int quantity;

  const CounterWidget({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
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
