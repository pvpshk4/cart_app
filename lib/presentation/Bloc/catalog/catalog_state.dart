import 'package:equatable/equatable.dart';

import '../../../domain/entities/product.dart';

class CatalogState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CatalogLoading extends CatalogState {}

class CatalogLoaded extends CatalogState {
  final List<Product> products;
  CatalogLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class CatalogError extends CatalogState {
  final String message;
  CatalogError(this.message);

  @override
  List<Object?> get props => [message];
}
