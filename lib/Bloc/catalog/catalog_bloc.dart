import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/datasources/product_data.dart';
import 'catalog_exports.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final ProductRepository productRepository;

  CatalogBloc(this.productRepository) : super(CatalogLoading()) {
    on<LoadCatalog>((event, emit) {
      final products = productRepository.getProducts();
      emit(CatalogLoaded(products));
    });
  }
}
