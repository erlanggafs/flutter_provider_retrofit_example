import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
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
            : ListView.builder(
                itemCount: productProvider.products.length +
                    (productProvider.isLoadingMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == productProvider.products.length) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Show loading indicator at the end
                  }
                  final product = productProvider.products[index];
                  return ListTile(
                    leading: Image.network(product.image,
                        width: 50, fit: BoxFit.cover),
                    title: Text(product.title),
                    subtitle: Text('\$${product.price}'),
                    onTap: () {
                      // Handle product tap
                    },
                  );
                },
              ),
      ),
    );
  }
}
