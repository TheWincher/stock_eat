import 'package:stock_eat/domain/entities/product.dart';
import 'package:stock_eat/domain/entities/unit.dart';
import 'package:stock_eat/domain/repositories/product_repository.dart';
import 'package:uuid/uuid.dart';

class AddProductUseCase {
  AddProductUseCase(this._repository);

  final ProductRepository _repository;

  Future<void> call(
    String name,
    String categoryId,
    Unit defaultUnit,
    String? barcode,
  ) {
    final product = Product(
      id: const Uuid().v4(),
      name: name,
      categoryId: categoryId,
      defaultUnit: defaultUnit,
      barcode: barcode,
    );
    return _repository.add(product);
  }
}
