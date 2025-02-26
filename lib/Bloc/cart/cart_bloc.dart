import 'package:cart_app/models/cart_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_exports.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoaded(cart: [])) {
    on<AddToCart>(
      (event, emit) {
        final List<CartItem> cart = List.from(state.cart!);
        int itemIndex =
            cart.indexWhere((item) => item.product == event.product);
        if (itemIndex == -1) {
          cart.add(CartItem(product: event.product, quantity: 1));
        } else {
          cart[itemIndex] =
              cart[itemIndex].copyWith(quantity: cart[itemIndex].quantity + 1);
        }
        emit(CartLoaded(cart: cart));
      },
    );

    on<RemoveFromCart>(
      (event, emit) {
        final List<CartItem> cart = List.from(state.cart!);
        int itemIndex =
            cart.indexWhere((item) => item.product == event.product);
        if (itemIndex != -1) {
          if (cart[itemIndex].quantity > 1) {
            cart[itemIndex] = cart[itemIndex]
                .copyWith(quantity: cart[itemIndex].quantity - 1);
          } else {
            cart.removeAt(itemIndex);
          }
        }
        emit(CartLoaded(cart: cart));
      },
    );

    on<DeleteFromCart>(
      (event, emit) {
        final List<CartItem> cart = List.from(state.cart!);
        cart.removeWhere((item) => item.product == event.product);
        emit(CartLoaded(cart: cart));
      },
    );
  }
}
