import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late List<bool> _selectedItems;

  @override
  void initState() {
    super.initState();
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    _selectedItems = List<bool>.filled(cartProvider.cartItems.length, false);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    // Hitung total harga untuk item yang dipilih
    double totalPrice = 0.0;
    final selectedItems = cartProvider.cartItems
        .asMap()
        .entries
        .where((entry) => _selectedItems[entry.key])
        .map((entry) {
      totalPrice += entry.value.price; // Tambah harga produk yang dipilih
      return entry.value;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: cartProvider.cartItems.isEmpty
          ? Center(child: Text('No items in cart.'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProvider.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartProvider.cartItems[index];
                      return ListTile(
                        leading: Image.network(
                          item.image, // Menampilkan gambar produk
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(item.title),
                        subtitle: Text('\$${item.price}'),
                        trailing: Checkbox(
                          value: _selectedItems[index],
                          onChanged: (value) {
                            setState(() {
                              _selectedItems[index] = value ?? false;
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Selected Products:',
                          style: TextStyle(fontSize: 18)),
                      ...selectedItems
                          .map((item) => Row(
                                children: [
                                  Image.network(
                                    item.image,
                                    width:
                                        50, // Ukuran gambar produk yang dipilih
                                    height: 50,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 8),
                                  Text(item.title),
                                ],
                              ))
                          .toList(),
                      SizedBox(height: 10),
                      Text('Total Price: \$${totalPrice.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            if (selectedItems.isNotEmpty) {
              // Logika untuk menyelesaikan pembayaran
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Checkout completed!')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('No items selected for checkout.')),
              );
            }
          },
          child: Text('Proceed to Payment'),
        ),
      ),
    );
  }
}
