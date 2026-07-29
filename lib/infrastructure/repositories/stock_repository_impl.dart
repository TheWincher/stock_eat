import 'package:stock_eat/domain/entities/stock_item.dart';
import 'package:stock_eat/domain/repositories/stock_repository.dart';
import 'package:stock_eat/infrastructure/database/app_database.dart';
import 'package:stock_eat/infrastructure/mappers/stock_item_mapper.dart';

class StockRepositoryImpl implements StockRepository {
  final AppDatabase _db;

  StockRepositoryImpl(this._db);

  @override
  Future<void> add(StockItem item) {
    return _db.into(_db.stockItems).insert(item.toCompanion());
  }

  @override
  Future<void> delete(String id) {
    return (_db.delete(_db.stockItems)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<void> update(StockItem item) {
    return _db.update(_db.stockItems).replace(item.toCompanion());
  }

  @override
  Stream<List<StockItem>> watchAll() {
    return _db
        .select(_db.stockItems)
        .watch()
        .map((rows) => rows.map((row) => row.toDomain()).toList());
  }
}
