import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stock_eat/presentation/providers/category_providers.dart';
import 'package:stock_eat/presentation/providers/usecase_providers.dart';

class AddCategoryPage extends ConsumerStatefulWidget {
  const AddCategoryPage({super.key});

  @override
  ConsumerState<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends ConsumerState<AddCategoryPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _controller.text.trim();
    if (name.isEmpty) return;
    await ref.read(addCategoryUseCaseProvider).call(name);
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(categoriesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Catégories')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'Nom de la catégorie',
                    ),
                  ),
                ),
                IconButton(icon: const Icon(Icons.add), onPressed: _submit),
              ],
            ),
          ),
          Expanded(
            child: categoriesAsync.when(
              data: (categories) => ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Dismissible(
                    key: ValueKey(category.id),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: const Icon(Icons.delete, color: Colors.white),
                    ),
                    confirmDismiss: (_) async {
                      try {
                        await ref
                            .read(deleteCategoryUsecaseProvider)
                            .call(category.id);
                        return true;
                      } catch (_) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Impossible de supprimer : catégorie encore utilisée par un produit',
                              ),
                            ),
                          );
                        }
                        return false;
                      }
                    },
                    child: ListTile(title: Text(category.name)),
                  );
                },
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
