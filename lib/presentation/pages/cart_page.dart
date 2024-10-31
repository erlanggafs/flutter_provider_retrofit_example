import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart'; // Pastikan path ini sesuai // Pastikan path ini sesuai
import 'check_out_page.dart'; // Pastikan import halaman checkout

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(child: Text('Your cart is empty'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartProvider.cartItems.length,
                      itemBuilder: (context, index) {
                        final product = cartProvider.cartItems[index];
                        return ListTile(
                          leading: Image.network(product.image, width: 50),
                          title: Text(product.title),
                          subtitle: Text('\$${product.price}'),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CheckoutPage()),
                      );
                    },
                    child: Text('Checkout'),
                  ),
                ],
              ),
            ),
    );
  }
}
