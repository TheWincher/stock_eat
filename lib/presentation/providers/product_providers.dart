import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_eat/domain/entities/product.dart';
import 'usecase_providers.dart';

final productsStreamProvider = StreamProvider<List<Product>>((ref) {
  return ref.watch(watchProductsUseCaseProvider).call();
});
