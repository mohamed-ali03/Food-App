import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/models/category%20model/category_model.dart';
import 'package:foodapp/models/item%20model/item_model.dart';
import 'package:foodapp/service/repositories/menu_repository.dart';

class MenuProvider extends ChangeNotifier {
  final _repo = MenuRepository();

  bool isLoading = false;
  String? error;
  bool _isDisposed = false;

  List<ItemModel> items = [];
  List<CategoryModel> categories = [];

  StreamSubscription? _itemsSub;
  StreamSubscription? _categoriesSub;

  MenuProvider() {
    sync();
    _repo.listenToChangesInCategoryTable();
    _repo.listenToChangesInItemsTable();

    _itemsSub = _repo.watchLocalMenu().listen((items) {
      this.items = items;
      notifyListeners();
    });

    _categoriesSub = _repo.watchCategories().listen((cats) {
      categories = cats;
      notifyListeners();
    });
  }

  // clear all local menu data (for logout)
  Future<void> clearAllData() async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.clearAllMenuData();
      _setLoading(false);
    } catch (e) {
      _setError('Failed to clear menu data: $e');
      debugPrint('Error clearing menu data: $e');
      _setLoading(false);
    }
  }

  /// 🔄 sync categories and menu items
  Future<void> sync() async {
    try {
      _setLoading(true);
      _setError(null);

      await _repo.syncCat();
      await _repo.syncMenu();

      _setLoading(false);
    } catch (e) {
      _setError('Failed to sync menu: $e');
      debugPrint('Error syncing: $e');
      _setLoading(false);
    }
  }

  Future<ItemModel?> getItem(int itemId) async {
    try {
      return await _repo.getItem(itemId);
    } catch (e) {
      return null;
    }
  }

  /// ➕ Add item
  Future<void> addItem(ItemModel item) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repo.addItem(item);

      _setLoading(false);
    } catch (e) {
      _setError('Failed to add item: $e');
      debugPrint('Error adding item: $e');
      _setLoading(false);
    }
  }

  /// ✏️ Update item
  Future<void> updateItem(ItemModel item) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repo.updateItem(item);

      _setLoading(false);
    } catch (e) {
      _setError('Failed to update item: $e');
      debugPrint('Error updating item: $e');
      _setLoading(false);
    }
  }

  /// 🗑️ Delete item
  Future<void> deleteItem(ItemModel item) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repo.deleteItem(item);

      _setLoading(false);
    } catch (e) {
      _setError('Failed to delete item: $e');
      debugPrint('Error deleting item: $e');
      _setLoading(false);
    }
  }

  /// ➕ Add category
  Future<void> addCat(CategoryModel category) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repo.addCat(category);

      _setLoading(false);
    } catch (e) {
      _setError('Failed to add category: $e');
      debugPrint('Error adding category: $e');
      _setLoading(false);
    }
  }

  /// ✏️ Update category
  Future<void> updateCat(CategoryModel? category) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repo.updateCat(category!);

      _setLoading(false);
    } catch (e) {
      _setError('Failed to update category: $e');
      debugPrint('Error updating category: $e');
      _setLoading(false);
    }
  }

  /// 🗑️ Delete category
  Future<void> deleteCat(CategoryModel category) async {
    try {
      _setLoading(true);
      _setError(null);

      await _repo.deleteCat(category);

      _setLoading(false);
    } catch (e) {
      _setError('Failed to delete category: $e');
      debugPrint('Error deleting category: $e');
      _setLoading(false);
    }
  }

  /// 🔧 Helper to safely set loading state
  void _setLoading(bool value) {
    if (!_isDisposed) {
      isLoading = value;
      notifyListeners();
    }
  }

  /// 🔧 Helper to safely set error state
  void _setError(String? value) {
    if (!_isDisposed) {
      error = value;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _repo.dispose();
    _itemsSub?.cancel();
    _categoriesSub?.cancel();
    super.dispose();
  }
}
