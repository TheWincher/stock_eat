import 'package:drift/drift.dart';
import 'package:stock_eat/domain/entities/stock_item.dart';
import 'package:stock_eat/infrastructure/database/app_database.dart';

extension StockItemRowMapper on StockItemRow {
  StockItem toDomain() => StockItem(
    id: id,
    productId: productId,
    quantity: quantity,
    unit: unit,
    location: location,
    addedAt: addedAt,
    expirationDate: expirationDate
  );
}

extension StockItemMapper on StockItem {
  StockItemsCompanion toCompanion() => StockItemsCompanion.insert(
    id: id,
    productId: productId,
    quantity: quantity,
    unit: unit,
    location: location,
    addedAt: addedAt,
    expirationDate: Value(expirationDate)
  );
}
