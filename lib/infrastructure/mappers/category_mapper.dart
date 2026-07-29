import 'package:stock_eat/domain/entities/category.dart';
import 'package:stock_eat/infrastructure/database/app_database.dart';

extension CategoryRowMapper on CategoryRow {
  Category toDomain() => Category(id: id, name: name);
}

extension CategoryMapper on Category {
  CategoriesCompanion toCompanion() =>
      CategoriesCompanion.insert(id: id, name: name);
}
