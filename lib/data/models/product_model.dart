import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product {
  ProductModel({
    required int id,
    required String title,
    required String description,
    required double price,
    required String image,
    required String category,
  }) : super(
          id: id,
          title: title,
          description: description,
          price: price,
          image: image,
          category: category,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
