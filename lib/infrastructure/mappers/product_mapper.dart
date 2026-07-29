import 'package:drift/drift.dart';
import 'package:stock_eat/domain/entities/product.dart';
import 'package:stock_eat/infrastructure/database/app_database.dart';

extension ProductRowMapper on ProductRow {
  Product toDomain() => Product(
    id: id,
    name: name,
    categoryId: categoryId,
    defaultUnit: defaultUnit,
    barcode: barcode,
  );
}

extension ProductMapper on Product {
  ProductsCompanion toCompanion() => ProductsCompanion.insert(
    id: id,
    name: name,
    categoryId: categoryId,
    defaultUnit: defaultUnit,
    barcode: Value(barcode),
  );
}
