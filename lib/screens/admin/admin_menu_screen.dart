import 'package:flutter/material.dart';
import 'package:foodapp/core/size_config.dart';
import 'package:foodapp/l10n/app_localizations.dart';
import 'package:foodapp/models/category%20model/category_model.dart';
import 'package:foodapp/models/item%20model/item_model.dart';
import 'package:foodapp/providers/menu_provider.dart';
import 'package:foodapp/screens/admin/widgets/admin_menu_item_dialog.dart';
import 'package:foodapp/screens/widgets/item_card.dart';
import 'package:foodapp/screens/admin/widgets/admin_menu_stats.dart';
import 'package:foodapp/screens/widgets/menu_search_filters.dart';
import 'package:foodapp/screens/admin/widgets/admin_menu_states.dart';
import 'package:provider/provider.dart';

// responsive : done

class AdminMenuScreen extends StatefulWidget {
  const AdminMenuScreen({super.key});

  @override
  State<AdminMenuScreen> createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState extends State<AdminMenuScreen> {
  final TextEditingController _searchController = TextEditingController();
  ValueNotifier<List<ItemModel>> filteredItems = ValueNotifier([]);
  ValueNotifier<Map<String, int>> stats = ValueNotifier({});

  String _searchQuery = '';
  int? _selectedCategoryId;
  bool _showAvailableOnly = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ItemModel> _getFilteredItems(List<ItemModel> items) {
    return items.where((item) {
      // Search filter
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        if (!item.name.toLowerCase().contains(query) &&
            !item.description.toLowerCase().contains(query)) {
          return false;
        }
      }

      // Category filter
      if (_selectedCategoryId != null &&
          item.categoryId != _selectedCategoryId) {
        return false;
      }

      // Availability filter
      if (_showAvailableOnly && !item.available) {
        return false;
      }

      return true;
    }).toList();
  }

  Map<String, int> _calculateStats(List<ItemModel> items) {
    return {
      'total': items.length,
      'available': items.where((item) => item.available).length,
      'outOfStock': items.where((item) => !item.available).length,
    };
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => MenuItemFormDialog(
        isEdit: false,
        onSave:
            (
              name,
              price,
              description,
              categoryId,
              available,
              imageUrl,
              ingreidents,
            ) {
              final newItem = ItemModel()
                ..name = name
                ..description = description
                ..price = price
                ..categoryId = categoryId
                ..imageUrl = imageUrl
                ..ingreidents = ingreidents
                ..available = available;

              context.read<MenuProvider>().addItem(newItem);
              Navigator.pop(context);
            },
      ),
    );
  }

  void _showEditItemDialog(BuildContext context, ItemModel item) {
    showDialog(
      context: context,
      builder: (context) => MenuItemFormDialog(
        isEdit: true,
        initialItem: item,
        onSave:
            (
              name,
              price,
              description,
              categoryId,
              available,
              imageUrl,
              ingreidents,
            ) {
              final updatedItem = ItemModel()
                ..itemId = item.itemId
                ..name = name
                ..description = description
                ..price = price
                ..categoryId = categoryId
                ..imageUrl = imageUrl.isNotEmpty ? imageUrl : item.imageUrl
                ..ingreidents = ingreidents
                ..available = available;

              context.read<MenuProvider>().updateItem(updatedItem);
              Navigator.pop(context);
            },
      ),
    );
  }

  void _showAddCategoryDialog(BuildContext context, {int? categoryId}) async {
    MenuProvider menuProvider = context.read<MenuProvider>();
    TextEditingController cat = TextEditingController();

    late CategoryModel category;

    if (categoryId != null) {
      category = menuProvider.categories.firstWhere(
        (c) => c.categoryId == categoryId,
      );
      cat.text = category.name;
    }

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context).t('addCategory')),
        content: TextFormField(
          controller: cat,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context).t('categoryName'),
            hintText: AppLocalizations.of(context).t('e.g., Burger Pizza'),
            border: const OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocalizations.of(context).t('pleaseEnterCategoryName');
            }
            return null;
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context).t('cancel')),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context).t('confirm')),
          ),
        ],
      ),
    );

    if (confirmed == false || confirmed == null) return;

    if (categoryId == null) {
      await menuProvider.addCat(CategoryModel()..name = cat.text);
    } else {
      category.name = cat.text;
      await menuProvider.updateCat(category);
    }

    if (!context.mounted) return;
    if (menuProvider.error != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(menuProvider.error!)));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Category add successfully')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).t('menuManagement')),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddItemDialog(context),
        icon: const Icon(Icons.add),
        label: Text(AppLocalizations.of(context).t('addItem')),
      ),
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.blockHight * 2),
        child: Consumer<MenuProvider>(
          builder: (context, menuProvider, child) {
            if (menuProvider.isLoading && menuProvider.items.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (menuProvider.items.isEmpty || menuProvider.categories.isEmpty) {
              return AdminMenuEmptyState(
                onAddItem: () => _showAddItemDialog(context),
              );
            }

            filteredItems.value = _getFilteredItems(menuProvider.items);
            stats.value = _calculateStats(menuProvider.items);

            return CustomScrollView(
              slivers: [
                // Stats Section
                SliverToBoxAdapter(
                  child: ValueListenableBuilder(
                    valueListenable: stats,
                    builder: (context, value, child) {
                      return AdminMenuStats(stats: value);
                    },
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(height: SizeConfig.blockHight * 2),
                ),

                // Search and Filters
                SliverToBoxAdapter(
                  child: ValueListenableBuilder(
                    valueListenable: filteredItems,
                    builder: (context, value, child) {
                      return MenuSearchFilters(
                        searchController: _searchController,
                        searchQuery: _searchQuery,
                        selectedCategoryId: _selectedCategoryId,
                        showAvailableOnly: _showAvailableOnly,
                        categories: menuProvider.categories,
                        addCategory: () => _showAddCategoryDialog(context),
                        editCategory: (value) =>
                            _showAddCategoryDialog(context, categoryId: value),
                        onSearchChanged: (value) {
                          _searchQuery = value;
                          filteredItems.value = _getFilteredItems(
                            menuProvider.items,
                          );
                        },
                        onCategoryChanged: (value) {
                          _selectedCategoryId = value;
                          filteredItems.value = _getFilteredItems(
                            menuProvider.items,
                          );
                        },
                        onAvailableToggle: (value) {
                          _showAvailableOnly = value;
                          filteredItems.value = _getFilteredItems(
                            menuProvider.items,
                          );
                        },
                        onClearFilters: () {
                          _searchQuery = '';
                          _selectedCategoryId = null;
                          _showAvailableOnly = false;
                          _searchController.clear();
                          filteredItems.value = _getFilteredItems(
                            menuProvider.items,
                          );
                        },
                      );
                    },
                  ),
                ),

                SliverToBoxAdapter(
                  child: SizedBox(height: SizeConfig.blockHight * 2),
                ),

                // Items List
                ValueListenableBuilder(
                  valueListenable: filteredItems,
                  builder: (context, value, child) {
                    if (value.isEmpty) {
                      return SliverFillRemaining(
                        child: AdminMenuNoResultsState(
                          onClearFilters: () {
                            _searchQuery = '';
                            _selectedCategoryId = null;
                            _showAvailableOnly = false;
                            _searchController.clear();
                            filteredItems.value = _getFilteredItems(
                              menuProvider.items,
                            );
                          },
                        ),
                      );
                    } else {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final item = value[index];
                          final category = menuProvider.categories.firstWhere(
                            (cat) => cat.categoryId == item.categoryId,
                            orElse: () => CategoryModel()
                              ..name = AppLocalizations.of(context).t('unknown')
                              ..categoryId = 0,
                          );

                          return ItemCard(
                            item: item,
                            categoryName: category.name,
                            onEdit: () => _showEditItemDialog(context, item),
                          );
                        }, childCount: value.length),
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
