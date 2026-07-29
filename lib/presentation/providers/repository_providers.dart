import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_eat/domain/repositories/category_repository.dart';
import 'package:stock_eat/domain/repositories/product_repository.dart';
import 'package:stock_eat/domain/repositories/stock_repository.dart';
import 'package:stock_eat/infrastructure/repositories/category_repository_impl.dart';
import 'package:stock_eat/infrastructure/repositories/product_repository_impl.dart';
import 'package:stock_eat/infrastructure/repositories/stock_repository_impl.dart';
import 'database_providers.dart';

final categoryRepositoryProvider = Provider<CategoryRepository>((ref) {
  return CategoryRepositoryImpl(ref.watch(appDatabaseProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.watch(appDatabaseProvider));
});

final stockRepositoryProvider = Provider<StockRepository>((ref) {
  return StockRepositoryImpl(ref.watch(appDatabaseProvider));
});