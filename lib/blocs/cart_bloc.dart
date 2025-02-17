import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

abstract class CartEvent {}

class AddToCart extends CartEvent {
  final Product product;
  AddToCart(this.product);
}

class RemoveFromCart extends CartEvent {
  final Product product;
  RemoveFromCart(this.product);
}

abstract class CartState {}

class CartUpdated extends CartState {
  final List<CartItem> items;
  CartUpdated(this.items);
}

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartUpdated([])) {
    on<AddToCart>((event, emit) {
      final currentState = state as CartUpdated;
      final updatedCart = List<CartItem>.from(currentState.items);

      final existingItem =
          updatedCart.indexWhere((item) => item.product.id == event.product.id);
      if (existingItem != -1) {
        updatedCart[existingItem].quantity++;
      } else {
        updatedCart.add(CartItem(product: event.product));
      }

      emit(CartUpdated(updatedCart));
    });

    on<RemoveFromCart>((event, emit) {
      final currentState = state as CartUpdated;
      final updatedCart = List<CartItem>.from(currentState.items)
        ..removeWhere((item) => item.product.id == event.product.id);

      emit(CartUpdated(updatedCart));
    });
  }
}
