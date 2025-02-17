import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final Map<Product, int> cart;
  CartLoaded(this.cart);
}

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);
}

class DeleteFromCart extends CartEvent {
  final Product product;
  DeleteFromCart(this.product);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  final Map<Product, int> _cart = {};

  CartBloc() : super(CartLoaded({})) {
    on<AddToCart>(
      (event, emit) {
        _cart.update(event.product, (quantity) => quantity + 1,
            ifAbsent: () => 1);
        emit(
          CartLoaded(
            Map.from(_cart),
          ),
        );
      },
    );

    on<RemoveFromCart>(
      (event, emit) {
        if (_cart.containsKey(event.product)) {
          int quantity = _cart[event.product]!;
          if (quantity > 1) {
            _cart[event.product] = quantity - 1;
          } else {
            _cart.remove(event.product);
          }
        }
        emit(
          CartLoaded(
            Map.from(_cart),
          ),
        );
      },
    );

    on<DeleteFromCart>(
      (event, emit) {
        _cart.remove(event.product);
        emit(
          CartLoaded(
            Map.from(_cart),
          ),
        );
      },
    );
  }
}
