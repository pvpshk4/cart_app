// main.dart

import 'package:cart_app/catalog_screen.dart';
import 'package:cart_app/components/product_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ProductListBloc(), // Создаем Bloc
        child: CatalogScreen(),
      ),
    );
  }
}
