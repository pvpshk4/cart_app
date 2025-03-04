import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:postgres/postgres.dart';
import 'data/datasources/product_data_source_impl.dart';
import 'data/repositories/product_repository_impl.dart';
import 'domain/usecases/get_products.dart';
import 'presentation/Bloc/cart/cart_bloc.dart';
import 'presentation/Bloc/catalog/catalog_bloc.dart';
import 'presentation/Bloc/catalog/catalog_exports.dart' show LoadCatalog;
import 'presentation/screens/catalog_screen.dart';
import 'presentation/screens/cart_screen.dart';

void main() async {
  final connection = await Connection.open(
    Endpoint(
      host: 'localhost',
      port: 5432,
      database: 'cart_app_db',
      username: 'postgres',
      password: '123123',
    ),
  );

  //Repositories
  final productDataSource = ProductDataSourceImpl(connection);
  final productRepository = ProductRepositoryImpl(productDataSource);

  //UseCases
  final getProducts = GetProducts(productRepository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CatalogBloc(getProducts)..add(LoadCatalog()),
        ),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Каталог с корзиной',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => CatalogScreen(),
        '/cart': (context) => CartScreen(),
      },
    );
  }
}
