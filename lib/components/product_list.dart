import 'package:bloc/bloc.dart';
import 'package:cart_app/components/product_item.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc()
      : super(
          ProductListState(
            allItems: [
              ProductItem(name: 'Item 1', imageUrl: 'imageUrl'),
              ProductItem(name: 'Item 2', imageUrl: 'imageUrl'),
              ProductItem(name: 'Item 3', imageUrl: 'imageUrl'),
            ],
            selectedItems: [],
          ),
        );

  Stream<ProductListState> mapEventToState(ProductListEvent event) async* {
    if (event is AddToCart) {
      // Добавляем элемент в список выбранных
      yield ProductListState(
        allItems: state.allItems,
        selectedItems: List.from(state.selectedItems)..add(event.item),
      );
    } else if (event is RemoveFromCart) {
      // Удаляем элемент из списка выбранных
      yield ProductListState(
        allItems: state.allItems,
        selectedItems: List.from(state.selectedItems)..remove(event.item),
      );
    }
  }
}

abstract class ProductListEvent {}

class AddToCart extends ProductListEvent {
  final ProductItem item;

  AddToCart(this.item);
}

class RemoveFromCart extends ProductListEvent {
  final ProductItem item;

  RemoveFromCart(this.item);
}

class ProductListState {
  final List<ProductItem> allItems;
  final List<ProductItem> selectedItems;

  ProductListState({required this.allItems, required this.selectedItems});
}
