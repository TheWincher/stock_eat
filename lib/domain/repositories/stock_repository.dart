import 'package:stock_eat/domain/entities/stock_item.dart';

abstract class StockRepository {
  Stream<List<StockItem>> watchAll();
  Future<void> add(StockItem item);
  Future<void> delete(String id);
  Future<void> update(StockItem item);
}