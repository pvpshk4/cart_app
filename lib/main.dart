import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/cart/cart_bloc.dart';
import 'Bloc/catalog/catalog_exports.dart';
import 'data/datasources/product_data.dart';
import 'presentation/screens/catalog_screen.dart';
import 'presentation/screens/cart_screen.dart';

void main() {
  final productRepository = ProductRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                CatalogBloc(productRepository)..add(LoadCatalog())),
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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => CatalogScreen(),
        '/cart': (context) => CartScreen(),
      },
    );
  }
}
