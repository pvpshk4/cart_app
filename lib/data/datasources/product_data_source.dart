import '../../domain/entities/product.dart';

abstract class ProductDataSource {
  Future<List<Product>> getProducts();
}
