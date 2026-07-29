import 'package:stock_eat/domain/entities/category.dart';
import 'package:stock_eat/domain/repositories/category_repository.dart';
import 'package:stock_eat/infrastructure/database/app_database.dart';
import 'package:stock_eat/infrastructure/mappers/category_mapper.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  CategoryRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Category>> watchAll() {
    return _db.select(_db.categories).watch().map(
      (rows) => rows.map((row) => row.toDomain()).toList(),
    );
  }

  @override
  Future<void> add(Category category) {
    return _db.into(_db.categories).insert(category.toCompanion());
  }

  @override
  Future<void> delete(String id) {
    return (_db.delete(_db.categories)..where((t) => t.id.equals(id))).go();
  }
}
