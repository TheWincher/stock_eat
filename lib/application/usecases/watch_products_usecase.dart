import 'package:stock_eat/domain/entities/product.dart';
import 'package:stock_eat/domain/repositories/product_repository.dart';

class WatchProductsUseCase {
  WatchProductsUseCase(this._repository);

  final ProductRepository _repository;

  Stream<List<Product>> call() => _repository.watchAll();
}
