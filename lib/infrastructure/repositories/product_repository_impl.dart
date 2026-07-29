import 'package:stock_eat/domain/entities/product.dart';
import 'package:stock_eat/domain/repositories/product_repository.dart';
import 'package:stock_eat/infrastructure/database/app_database.dart';
import 'package:stock_eat/infrastructure/mappers/product_mapper.dart';

class ProductRepositoryImpl implements ProductRepository {
  final AppDatabase _db;

  ProductRepositoryImpl(this._db);

  @override
  Future<void> add(Product product) {
    return _db.into(_db.products).insert(product.toCompanion());
  }

  @override
  Future<void> delete(String id) {
    return (_db.delete(_db.products)..where((t) => t.id.equals(id))).go();
  }

  @override
  Future<Product?> getById(String id) {
    return (_db.select(_db.products)..where((t) => t.id.equals(id)))
        .getSingleOrNull()
        .then((row) => row?.toDomain());
  }

  @override
  Stream<List<Product>> watchAll() {
    return _db
        .select(_db.products)
        .watch()
        .map((rows) => rows.map((row) => row.toDomain()).toList());
  }
}
