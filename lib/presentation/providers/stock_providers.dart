import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_eat/domain/entities/stock_item.dart';
import 'usecase_providers.dart';

final stockItemsStreamProvider = StreamProvider<List<StockItem>>((ref) {
  return ref.watch(watchStockItemsUseCaseProvider).call();
});
