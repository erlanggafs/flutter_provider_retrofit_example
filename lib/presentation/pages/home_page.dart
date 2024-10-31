import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';
import '../provider/cart_provider.dart'; // Import CartProvider
import 'check_out_page.dart';
import 'product_detail_page.dart'; // Import halaman detail produk // Import halaman Checkout

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider =
        Provider.of<CartProvider>(context); // Ambil CartProvider

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
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
              // Navigasi ke halaman cart
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutPage()),
              );
            },
          ),
        ],
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!productProvider.isLoading &&
              !productProvider.isLoadingMore &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            productProvider
                .loadMoreProducts(); // Load more when reaching bottom
          }
          return true;
        },
        child: productProvider.isLoading && productProvider.products.isEmpty
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Jumlah kolom
                  crossAxisSpacing: 2.0,
                  mainAxisSpacing: 2.0,
                  childAspectRatio: 0.8, // Rasio aspek item
                ),
                itemCount: productProvider.products.length +
                    (productProvider.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == productProvider.products.length) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    ); // Show loading indicator at the end
                  }
                  final product = productProvider.products[index];
                  return GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman detail produk
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProductDetailPage(product: product),
                        ),
                      );
                    },
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(8.0),
                            ),
                            child: Image.network(
                              product.image,
                              width: double.infinity,
                              height: 100, // Atur tinggi gambar
                              fit: BoxFit
                                  .cover, // Pastikan gambar tidak overflow
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 4),
                                Text('\$${product.price}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
