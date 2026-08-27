import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_eat/application/usecases/add_category_usecase.dart';
import 'package:stock_eat/application/usecases/add_product_usecase.dart';
import 'package:stock_eat/application/usecases/add_stock_item_usecase.dart';
import 'package:stock_eat/application/usecases/delete_category_usecase.dart';
import 'package:stock_eat/application/usecases/delete_stock_item_usecase.dart';
import 'package:stock_eat/application/usecases/watch_categories_usecase.dart';
import 'package:stock_eat/application/usecases/watch_products_usecase.dart';
import 'package:stock_eat/application/usecases/watch_stock_items_usecase.dart';
import 'repository_providers.dart';

final addCategoryUseCaseProvider = Provider<AddCategoryUseCase>((ref) {
  return AddCategoryUseCase(ref.watch(categoryRepositoryProvider));
});

final addProductUseCaseProvider = Provider<AddProductUseCase>((ref) {
  return AddProductUseCase(ref.watch(productRepositoryProvider));
});

final addStockItemUseCaseProvider = Provider<AddStockItemUseCase>((ref) {
  return AddStockItemUseCase(ref.watch(stockRepositoryProvider));
});

final watchStockItemsUseCaseProvider = Provider<WatchStockItemsUseCase>((ref) {
  return WatchStockItemsUseCase(ref.watch(stockRepositoryProvider));
});

final watchCategoriesUseCaseProvider = Provider<WatchCategoriesUseCase>((ref) {
  return WatchCategoriesUseCase(ref.watch(categoryRepositoryProvider));
});

final watchProductsUseCaseProvider = Provider<WatchProductsUseCase>((ref) {
  return WatchProductsUseCase(ref.watch(productRepositoryProvider));
});

final deleteStockItemUseCaseProvider = Provider<DeleteStockItemUseCase>((ref) {
  return DeleteStockItemUseCase(ref.watch(stockRepositoryProvider));
});

final deleteCategoryUsecaseProvider = Provider<DeleteCategoryUsecase>((ref) {
  return DeleteCategoryUsecase(ref.watch(categoryRepositoryProvider));
});
