import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_eat/domain/entities/product.dart';
import 'package:stock_eat/domain/entities/storage_location.dart';
import 'package:stock_eat/domain/entities/unit.dart';
import 'package:stock_eat/presentation/providers/product_providers.dart';
import 'package:stock_eat/presentation/providers/usecase_providers.dart';

class AddStockItemPage extends ConsumerStatefulWidget {
  const AddStockItemPage({super.key});

  @override
  ConsumerState<AddStockItemPage> createState() => _AddStockItemPageState();
}

class _AddStockItemPageState extends ConsumerState<AddStockItemPage> {
  final _quantityController = TextEditingController();
  Product? _selectedProduct;
  Unit _selectedUnit = Unit.piece;
  StorageLocation _selectedLocation = StorageLocation.fridge;
  DateTime? _expirationDate;

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  Future<void> _pickExpirationDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 1)),
      lastDate: now.add(const Duration(days: 365 * 3)),
    );
    if (picked != null) setState(() => _expirationDate = picked);
  }

  Future<void> _submit() async {
    final product = _selectedProduct;
    final quantity = double.tryParse(_quantityController.text.replaceAll(',', '.'));
    if (product == null || quantity == null) return;

    await ref.read(addStockItemUseCaseProvider).call(
      product.id,
      quantity,
      _selectedUnit,
      _selectedLocation,
      _expirationDate,
    );
    _quantityController.clear();
    setState(() => _expirationDate = null);
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter au stock')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            productsAsync.when(
              data: (products) => DropdownButtonFormField<Product>(
                initialValue: _selectedProduct,
                decoration: const InputDecoration(labelText: 'Produit'),
                items: products
                    .map((p) => DropdownMenuItem(value: p, child: Text(p.name)))
                    .toList(),
                onChanged: (value) => setState(() {
                  _selectedProduct = value;
                  if (value != null) _selectedUnit = value.defaultUnit;
                }),
              ),
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Erreur : $error'),
            ),
            TextField(
              controller: _quantityController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Quantité'),
            ),
            DropdownButtonFormField<Unit>(
              initialValue: _selectedUnit,
              decoration: const InputDecoration(labelText: 'Unité'),
              items: Unit.values
                  .map((u) => DropdownMenuItem(value: u, child: Text(u.name)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedUnit = value!),
            ),
            DropdownButtonFormField<StorageLocation>(
              initialValue: _selectedLocation,
              decoration: const InputDecoration(labelText: 'Emplacement'),
              items: StorageLocation.values
                  .map((l) => DropdownMenuItem(value: l, child: Text(l.name)))
                  .toList(),
              onChanged: (value) => setState(() => _selectedLocation = value!),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _expirationDate == null
                      ? 'Pas de DLC'
                      : 'DLC : ${_expirationDate!.day}/${_expirationDate!.month}/${_expirationDate!.year}',
                ),
                TextButton(onPressed: _pickExpirationDate, child: const Text('Choisir une date')),
              ],
            ),
            const SizedBox(height: 8),
            ElevatedButton(onPressed: _submit, child: const Text('Ajouter au stock')),
          ],
        ),
      ),
    );
  }
}
