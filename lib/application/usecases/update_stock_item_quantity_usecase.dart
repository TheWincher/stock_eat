import 'package:stock_eat/domain/entities/stock_item.dart';
import 'package:stock_eat/domain/repositories/stock_repository.dart';

class UpdateStockItemQuantityUsecase {
  final StockRepository _repository;

  UpdateStockItemQuantityUsecase(this._repository);

  Future<void> call(StockItem item, double newQuantity) {
    return _repository.update(item.copyWith(quantity: newQuantity));
  }
}