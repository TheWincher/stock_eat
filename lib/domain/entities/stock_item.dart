import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:stock_eat/domain/entities/storage_location.dart';
import 'package:stock_eat/domain/entities/unit.dart';

part 'stock_item.freezed.dart'; 

@freezed
abstract class StockItem with _$StockItem {
  const factory StockItem({
    required String id,
    required String productId,
    required double quantity,
    required StorageLocation location,
    required Unit unit,
    required DateTime addedAt,
    DateTime? expirationDate,
  }) = _StockItem;
}