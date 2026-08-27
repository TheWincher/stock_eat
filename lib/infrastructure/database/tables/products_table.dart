import 'package:drift/drift.dart';
import 'package:stock_eat/domain/entities/unit.dart';
import 'package:stock_eat/infrastructure/database/tables/categories_table.dart';

@DataClassName('ProductRow')
class Products extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get categoryId =>
      text().references(Categories, #id, onDelete: KeyAction.restrict)();
  IntColumn get defaultUnit => intEnum<Unit>()();
  TextColumn get barcode => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
