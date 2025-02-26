import '../../data/models/product.dart';

abstract class CatalogState {}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Product> products;
  CatalogLoaded(this.products);
}
