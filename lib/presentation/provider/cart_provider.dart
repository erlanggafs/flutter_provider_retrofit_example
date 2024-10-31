import 'package:flutter/material.dart';
import '../../domain/entities/product.dart'; // Pastikan path ini sesuai dengan model Product Anda

class CartProvider with ChangeNotifier {
  final List<Product> _cartItems = [];

  List<Product> get cartItems => _cartItems;

  void addToCart(Product product) {
    _cartItems.add(product);
    notifyListeners();
  }

  int get cartCount => _cartItems.length;
}
