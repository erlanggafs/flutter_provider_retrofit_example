import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import '../models/product_model.dart';

part 'product_remote_data_source.g.dart';

@RestApi(baseUrl: "https://fakestoreapi.com/")
abstract class ProductRemoteDataSource {
  factory ProductRemoteDataSource(Dio dio, {String baseUrl}) =
      _ProductRemoteDataSource;

  @GET("products")
  Future<List<ProductModel>> fetchProducts(
      @Query("page") int page, @Query("limit") int limit);
}
