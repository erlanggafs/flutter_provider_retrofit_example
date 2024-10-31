import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

class ProductProvider with ChangeNotifier {
  final ProductRepository repository;

  ProductProvider(this.repository);

  List<Product> _products = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  int _currentPage = 1;
  final int _limit = 5;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  bool get isLoadingMore => _isLoadingMore;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    final products = await repository.fetchProducts(_currentPage, _limit);
    _products.addAll(products);
    _currentPage++;
    _isLoading = false;
    notifyListeners();
  }

  Future<void> loadMoreProducts() async {
    if (_isLoadingMore) return;
    _isLoadingMore = true;
    notifyListeners();

    await fetchProducts();

    _isLoadingMore = false;
    notifyListeners();
  }
}
