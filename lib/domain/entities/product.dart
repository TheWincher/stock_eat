import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_eat/domain/entities/unit.dart';

part 'product.freezed.dart'; 

@freezed
abstract class Product with _$Product {
  const factory Product({
    required String id,
    required String name,
    required String categoryId,
    required Unit defaultUnit,
    String? barcode,
  }) = _Product;
}