import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider/presentation/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import 'data/repositories/product_repositoriy.dart';
import 'data/sources/product_remote_data_source.dart';
import 'domain/repositories/product_repository.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/provider/product_provider.dart';

void main() {
  final dio = Dio(); // Create Dio instance
  final productRemoteDataSource =
      ProductRemoteDataSource(dio); // Create remote data source
  final productRepository =
      ProductRepositoryImpl(productRemoteDataSource); // Create repository

  runApp(MyApp(productRepository));
}

class MyApp extends StatelessWidget {
  final ProductRepository repository;

  MyApp(this.repository);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => ProductProvider(repository)..fetchProducts()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
      ],
      child: MaterialApp(
        title: 'Product App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
