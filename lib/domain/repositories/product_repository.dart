import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts(int page, int limit);
}
