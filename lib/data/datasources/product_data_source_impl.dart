import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';
import '../../domain/entities/product.dart';
import 'product_data_source.dart';

class ProductDataSourceImpl implements ProductDataSource {
  final Connection _connection;

  ProductDataSourceImpl(this._connection);

  @override
  Future<List<Product>> getProducts() async {
    final List<Product> products = [];

    try {
      final result = await _connection.execute('SELECT * FROM products');

      for (final row in result) {
        final product = Product(
          id: row[0] as int,
          name: row[1] as String,
          imageUrl: row[2] as String,
          price: row[3] as double,
        );
        products.add(product);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Ошибка при получении продуктов: $e');
      }
    } finally {
      await _connection.close();
    }

    return products;
  }
}
