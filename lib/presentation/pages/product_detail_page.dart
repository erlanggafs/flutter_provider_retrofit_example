import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/product.dart'; // Pastikan Anda memiliki model Product
import '../provider/cart_provider.dart'; // Import CartProvider
import 'check_out_page.dart'; // Import halaman Checkout

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final cartProvider =
        Provider.of<CartProvider>(context); // Ambil CartProvider

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_cart),
                if (cartProvider.cartCount > 0) // Jika ada item di cart
                  Positioned(
                    right: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '${cartProvider.cartCount}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            onPressed: () {
              // Navigasi ke halaman cart (Anda bisa buat halaman cart sendiri)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutPage()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.image,
              fit: BoxFit.cover,
              height: 250,
              width: double.infinity,
            ),
            SizedBox(height: 16),
            Text(
              product.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              '\$${product.price}',
              style: TextStyle(fontSize: 20, color: Colors.green),
            ),
            SizedBox(height: 16),
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                cartProvider.addToCart(product); // Tambahkan produk ke cart
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${product.title} added to cart!'),
                    action: SnackBarAction(
                      label: 'Checkout',
                      onPressed: () {
                        // Navigasi ke halaman checkout
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckoutPage()),
                        );
                      },
                    ),
                  ),
                );
              },
              child: Text('Add to Cart'),
            ),
          ],
        ),
      ),
    );
  }
}
