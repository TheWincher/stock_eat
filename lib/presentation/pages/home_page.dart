import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_eat/presentation/pages/add_category_page.dart';
import 'package:stock_eat/presentation/pages/add_product_page.dart';
import 'package:stock_eat/presentation/pages/add_stock_item_page.dart';
import 'package:stock_eat/presentation/providers/stock_providers.dart';

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
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text('${item.quantity} ${item.unit.name}'),
                subtitle: Text('Produit: ${item.productId}'),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Erreur : $error')),
      ),
    );
  }
}
