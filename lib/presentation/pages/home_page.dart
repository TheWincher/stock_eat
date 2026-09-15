import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_eat/domain/entities/stock_item.dart';
import 'package:stock_eat/presentation/pages/add_category_page.dart';
import 'package:stock_eat/presentation/pages/add_product_page.dart';
import 'package:stock_eat/presentation/pages/add_stock_item_page.dart';
import 'package:stock_eat/presentation/providers/product_providers.dart';
import 'package:stock_eat/presentation/providers/stock_providers.dart';
import 'package:stock_eat/presentation/providers/usecase_providers.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Stock Eat', home: const StockListPage());
  }
}

class StockListPage extends ConsumerWidget {
  const StockListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockItemsAsync = ref.watch(stockItemsStreamProvider);
    final productsAsync = ref.watch(productsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon stock'),
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const AddCategoryPage())),
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const AddProductPage())),
          ),
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const AddStockItemPage())),
          ),
        ],
      ),

      body: stockItemsAsync.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(child: Text('Aucun article en stock'));
          }
          return productsAsync.when(
            data: (products) {
              final productsById = {for (final p in products) p.id: p};
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  final productName =
                      productsById[item.productId]?.name ?? 'Produit inconnu';

                  return Dismissible(
                    key: ValueKey(item.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    onDismissed: (_) {
                      ref.read(deleteStockItemUseCaseProvider).call(item.id);
                    },
                    child: ListTile(
                      title: Text(productName),
                      subtitle: Text(
                        '${item.quantity} ${item.unit.name} · ${item.location.name}',
                      ),
                      onTap: () => _showEditQuantityDialog(context, ref, item),
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(child: Text('Erreur : $error')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur : $error')),
      ),
    );
  }
}

Future<void> _showEditQuantityDialog(
  BuildContext context,
  WidgetRef ref,
  StockItem item,
) async {
  final newQuantity = await showDialog<double>(
    context: context,
    builder: (context) => _EditQuantityDialog(initialQuantity: item.quantity),
  );

  if (newQuantity == null) return;

  await ref
      .read(updateStockItemQuantityUsecaseProvider)
      .call(item, newQuantity);
}

class _EditQuantityDialog extends StatefulWidget {
  const _EditQuantityDialog({required this.initialQuantity});

  final double initialQuantity;

  @override
  State<_EditQuantityDialog> createState() => _EditQuantityDialogState();
}

class _EditQuantityDialogState extends State<_EditQuantityDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.initialQuantity.toString(),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Modifier la quantité'),
      content: TextField(
        controller: _controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Annuler'),
        ),
        TextButton(
          onPressed: () => Navigator.of(
            context,
          ).pop(double.tryParse(_controller.text.trim())),
          child: const Text('Enregistrer'),
        ),
      ],
    );
  }
}
