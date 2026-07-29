import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_eat/domain/entities/category.dart';
import 'package:stock_eat/domain/entities/unit.dart';
import 'package:stock_eat/presentation/providers/category_providers.dart';
import 'package:stock_eat/presentation/providers/product_providers.dart';
import 'package:stock_eat/presentation/providers/usecase_providers.dart';

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  @override
  ConsumerState<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  final _nameController = TextEditingController();
  final _barcodeController = TextEditingController();
  Category? _selectedCategory;
  Unit _selectedUnit = Unit.piece;

  @override
  void dispose() {
    _nameController.dispose();
    _barcodeController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    final category = _selectedCategory;
    if (name.isEmpty || category == null) return;

    final barcode = _barcodeController.text.trim();
    await ref.read(addProductUseCaseProvider).call(
      name,
      category.id,
      _selectedUnit,
      barcode.isEmpty ? null : barcode,
    );
    _nameController.clear();
    _barcodeController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesStreamProvider);
    final productsAsync = ref.watch(productsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Produits')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nom du produit'),
                ),
                categoriesAsync.when(
                  data: (categories) => DropdownButtonFormField<Category>(
                    initialValue: _selectedCategory,
                    decoration: const InputDecoration(labelText: 'Catégorie'),
                    items: categories
                        .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                        .toList(),
                    onChanged: (value) => setState(() => _selectedCategory = value),
                  ),
                  loading: () => const CircularProgressIndicator(),
                  error: (error, stack) => Text('Erreur : $error'),
                ),
                DropdownButtonFormField<Unit>(
                  initialValue: _selectedUnit,
                  decoration: const InputDecoration(labelText: 'Unité par défaut'),
                  items: Unit.values
                      .map((u) => DropdownMenuItem(value: u, child: Text(u.name)))
                      .toList(),
                  onChanged: (value) => setState(() => _selectedUnit = value!),
                ),
                TextField(
                  controller: _barcodeController,
                  decoration: const InputDecoration(labelText: 'Code-barres (optionnel)'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(onPressed: _submit, child: const Text('Ajouter')),
              ],
            ),
          ),
          Expanded(
            child: productsAsync.when(
              data: (products) => ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) =>
                    ListTile(title: Text(products[index].name)),
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Erreur : $error')),
            ),
          ),
        ],
      ),
    );
  }
}
