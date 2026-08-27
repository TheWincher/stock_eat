import 'package:stock_eat/domain/repositories/product_repository.dart';

class DeleteProductUsecase {
  final ProductRepository _repository;

  DeleteProductUsecase(this._repository);

  Future<void> call(String id) => _repository.delete(id);
}
