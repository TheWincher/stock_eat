import 'package:stock_eat/domain/entities/product.dart';

abstract class ProductRepository {
  Stream<List<Product>> watchAll();
  Future<Product?> getById(String id);
  Future<void> add(Product product);
  Future<void> delete(String id);
}