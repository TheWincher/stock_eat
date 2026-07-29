import 'package:stock_eat/domain/entities/category.dart';
import 'package:stock_eat/domain/repositories/category_repository.dart';

class WatchCategoriesUseCase {
  WatchCategoriesUseCase(this._repository);

  final CategoryRepository _repository;

  Stream<List<Category>> call() => _repository.watchAll();
}
