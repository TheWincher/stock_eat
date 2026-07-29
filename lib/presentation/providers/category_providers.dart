import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_eat/domain/entities/category.dart';
import 'usecase_providers.dart';

final categoriesStreamProvider = StreamProvider<List<Category>>((ref) {
  return ref.watch(watchCategoriesUseCaseProvider).call();
});
