import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../sources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Product>> fetchProducts(int page, int limit) async {
    final productModels = await remoteDataSource.fetchProducts(page, limit);
    return productModels;
  }
}
