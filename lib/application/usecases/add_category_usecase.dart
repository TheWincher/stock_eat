import 'package:uuid/uuid.dart';
import 'package:stock_eat/domain/entities/category.dart';
import 'package:stock_eat/domain/repositories/category_repository.dart';

class AddCategoryUseCase {
  AddCategoryUseCase(this._repository);

  final CategoryRepository _repository;

  Future<void> call(String name) {
    final category = Category(id: const Uuid().v4(), name: name);
    return _repository.add(category);
  }
}
