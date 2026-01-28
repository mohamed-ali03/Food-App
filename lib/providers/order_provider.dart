import 'dart:async';

import 'package:flutter/material.dart';
import 'package:foodapp/models/order%20item%20model/order_item_model.dart';
import 'package:foodapp/models/order%20model/order_model.dart';
import 'package:foodapp/service/repositories/order_repository.dart';
import 'package:isar/isar.dart';

class OrderProvider extends ChangeNotifier {
  final _repo = OrderRepository();

  bool isLoading = true;
  String? error;
  bool _isDisposed = false;

  List<OrderModel> orders = [];
  List<OrderItemModel> orderItems = [];

  late StreamSubscription _orderSub;
  late StreamSubscription _orderItemSub;

  OrderProvider(String? role) {
    _init(role);
    _orderSub = _repo.watchOrders().listen((orders) {
      this.orders = orders;
      _setLoading(false);
    });

    _orderItemSub = _repo.watchOrderItems().listen((orderItems) {
      this.orderItems = orderItems;
      _setLoading(false);
    });
  }

  Future<void> _init(String? role) async {
    try {
      _setError(null);
      // sync orders
      // await _repo.fetchAllOrders();

      // Start realtime AFTER init
      _repo.listenToOrderChanges(role ?? 'user');
      _repo.listenToOrderItemsChanges();
    } catch (e) {
      _setError('Failed to initialize orders: $e');
      debugPrint('Error initializing orders: $e');
      _setLoading(false);
    }
  }

  // clear all orders and order items (for logout)
  Future<void> clearAllData() async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.clearAllOrdersAndItems();
    } catch (e) {
      _setError('Failed to clear orders data: $e');
      debugPrint('Error clearing orders data: $e');
      _setLoading(false);
    }
  }

  //  =========================================================================================
  //                                           Order Item
  //  =========================================================================================
  // get Unsynced order items
  Future<List<OrderItemModel>> getUnsyncedOrderItems() async {
    return await _repo.getUnsyncedOrderItems();
  }

  /// add or update order item
  Future<void> upsertOrderItemLocally(OrderItemModel orderitem) async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.upsertOrderItem(orderitem);
    } catch (e) {
      _setError('Failed to add orderItem locally: $e');
      debugPrint('Error adding orderItem locally: $e');
      _setLoading(false);
    }
  }

  /// Update list of order items with (synced = false)
  Future<void> updateOrderItemsLocally(List<OrderItemModel> orderItems) async {
    try {
      if (orderItems.isEmpty) {
        debugPrint('No items to update');
        return;
      }
      _setError(null);
      _setLoading(true);
      await _repo.updateOrdersItem(orderItems);
    } catch (e) {
      _setError('Failed to update orderItem locally: $e');

      debugPrint('Error updating orderItem locally: $e');
      _setLoading(false);
    }
  }

  // delete order item by id
  Future<void> deleteOrderItemLocally({Id? id, int? itemId}) async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.deleteOrderItem(id: id, itemId: itemId);
    } catch (e) {
      _setError('Failed to delete orderItem locally: $e');
      debugPrint('Error deleting orderItem locally: $e');
      _setLoading(false);
    }
  }

  //  =========================================================================================
  //                                          Order
  //  =========================================================================================
  /// 📥 Get all orders from the remote DB
  Future<void> fetchAllOrders() async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.fetchAllOrders();
    } catch (e) {
      _setError('Failed to fetch orders: $e');
      debugPrint('Error fetching orders: $e');
      _setLoading(false);
    }
  }

  /// ➕ Place an order (offline-first)
  Future<void> placeOrder(OrderModel order, List<OrderItemModel> items) async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.placeOrder(order, items);
    } catch (e) {
      _setError('Failed to place order: $e');
      debugPrint('Error placing order: $e');
      _setLoading(false);
    }
  }

  /// Delete order
  Future<void> deleteOrder({int? orderId, int? id}) async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.deleteOrder(orderId: orderId, id: id);
    } catch (e) {
      _setError('Failed to delete order: $e');
      debugPrint('Error Deleting order: $e');
      _setLoading(false);
    }
  }

  /// 🔄 Retry syncing unsynced orders
  Future<void> syncOrders() async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.syncOrders();
    } catch (e) {
      _setError('Failed to sync orders: $e');
      debugPrint('Error syncing orders: $e');
      _setLoading(false);
    }
  }

  /// sync specific order
  Future<void> syncOrder(int id) async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.syncOrder(id);
    } catch (e) {
      _setError('Failed to sync order: $e');
      debugPrint('Error syncing order: $e');
      _setLoading(false);
    }
  }

  /// update order
  Future<void> updateOrder(int orderId, String status, {String? msg}) async {
    try {
      _setError(null);
      _setLoading(true);
      await _repo.updateOrder(orderId, status, msg: msg);
    } catch (e) {
      _setError('Failed to update orders: $e');
      debugPrint('Error Updating orders: $e');
      _setLoading(false);
    }
  }

  /// 🔧 Helper to safely set loading state
  void _setLoading(bool value) {
    try {
      if (!_isDisposed) {
        isLoading = value;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  /// 🔧 Helper to safely set error state
  void _setError(String? value) {
    try {
      if (!_isDisposed) {
        error = value;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    try {
      _isDisposed = true;
      _repo.dispose();
      _orderItemSub.cancel();
      _orderSub.cancel();
      super.dispose();
    } catch (e) {
      rethrow;
    }
  }
}
