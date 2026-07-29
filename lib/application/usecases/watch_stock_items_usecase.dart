import 'package:stock_eat/domain/entities/stock_item.dart';
import 'package:stock_eat/domain/repositories/stock_repository.dart';

class WatchStockItemsUseCase {
  WatchStockItemsUseCase(this._repository);

  final StockRepository _repository;

  Stream<List<StockItem>> call() {
    return _repository.watchAll().map((items) {
      final sorted = [...items];
      sorted.sort((a, b) {
        if (a.expirationDate == null && b.expirationDate == null) return 0;
        if (a.expirationDate == null) return 1;
        if (b.expirationDate == null) return -1;
        return a.expirationDate!.compareTo(b.expirationDate!);
      });
      return sorted;
    });
  }
}
