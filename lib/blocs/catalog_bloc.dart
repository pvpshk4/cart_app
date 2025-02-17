import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';
import '../repository/product_repository.dart';

// События
abstract class CatalogEvent {}

class LoadCatalog extends CatalogEvent {}

// Состояния
abstract class CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Product> products;
  CatalogLoaded(this.products);
}

// BLoC
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final ProductRepository productRepository;

  CatalogBloc(this.productRepository) : super(CatalogLoading()) {
    on<LoadCatalog>((event, emit) {
      final products = productRepository.getProducts();
      emit(CatalogLoaded(products));
    });
  }
}
