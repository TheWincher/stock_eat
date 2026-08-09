import 'package:stock_eat/domain/repositories/stock_repository.dart';

class DeleteStockItemUseCase {
  DeleteStockItemUseCase(this._repository);

  final StockRepository _repository;

  Future<void> call(String id) => _repository.delete(id);
}

