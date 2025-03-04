import 'package:equatable/equatable.dart';

import '../../../data/models/cart_item.dart';

class CartState extends Equatable {
  final List<CartItem>? cart;

  const CartState({this.cart});
  @override
  List<Object?> get props => [cart];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  const CartLoaded({
    super.cart,
  });
}
