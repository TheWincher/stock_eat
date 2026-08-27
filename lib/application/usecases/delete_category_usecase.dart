import 'package:stock_eat/domain/repositories/category_repository.dart';

class DeleteCategoryUsecase {
  DeleteCategoryUsecase(this._repository);

  final CategoryRepository _repository;

  Future<void> call(String id) => _repository.delete(id);
}
