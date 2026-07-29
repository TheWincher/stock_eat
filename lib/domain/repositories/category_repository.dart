import 'package:stock_eat/domain/entities/category.dart';

abstract class CategoryRepository {
  Stream<List<Category>> watchAll();
  Future<void> add(Category category);
  Future<void> delete(String id);
}