import 'package:stock_eat/domain/entities/stock_item.dart';
import 'package:stock_eat/domain/entities/storage_location.dart';
import 'package:stock_eat/domain/entities/unit.dart';
import 'package:stock_eat/domain/repositories/stock_repository.dart';
import 'package:uuid/uuid.dart';

class AddStockItemUseCase {
  AddStockItemUseCase(this._repository);

  final StockRepository _repository;

  Future<void> call(
    String productId,
    double quantity,
    Unit unit,
    StorageLocation location,
    DateTime? expirationDate,
  ) {
    final item = StockItem(
      id: const Uuid().v4(),
      addedAt: DateTime.now(),
      location: location,
      productId: productId,
      quantity: quantity,
      unit: unit,
      expirationDate: expirationDate
    );

    return _repository.add(item);
  }
}
