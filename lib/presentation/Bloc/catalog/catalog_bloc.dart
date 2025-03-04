import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_products.dart';
import 'catalog_exports.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final GetProducts getProducts;

  CatalogBloc(this.getProducts) : super(CatalogLoading()) {
    on<LoadCatalog>((event, emit) async {
      emit(CatalogLoading());
      try {
        final products = await getProducts();
        emit(CatalogLoaded(products));
      } catch (e) {
        emit(CatalogError('Ошибка загрузки каталога: $e'));
      }
    });
  }
}
