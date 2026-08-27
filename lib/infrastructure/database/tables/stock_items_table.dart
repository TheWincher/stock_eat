import 'package:drift/drift.dart';
import 'package:stock_eat/domain/entities/storage_location.dart';
import 'package:stock_eat/domain/entities/unit.dart';
import 'package:stock_eat/infrastructure/database/tables/products_table.dart';

@DataClassName('StockItemRow')
class StockItems extends Table {
  TextColumn get id => text()();
  TextColumn get productId =>
      text().references(Products, #id, onDelete: KeyAction.restrict)();
  RealColumn get quantity => real()();
  IntColumn get unit => intEnum<Unit>()();
  IntColumn get location => intEnum<StorageLocation>()();
  DateTimeColumn get expirationDate => dateTime().nullable()();
  DateTimeColumn get addedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
