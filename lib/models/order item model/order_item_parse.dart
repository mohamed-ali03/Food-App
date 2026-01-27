import 'order_item_model.dart';

extension OrderItemModelJson on OrderItemModel {
  /// Convert OrderItemModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': orderItemId,
      'order_id': orderId,
      'item_id': itemId,
      'quantity': quantity,
      'price': price,
    };
  }

  /// Create OrderItemModel from JSON
  static OrderItemModel fromJson(Map<String, dynamic> json) {
    return OrderItemModel()
      ..orderItemId = json['id']
      ..orderId = json['order_id']
      ..itemId = json['item_id']
      ..quantity = json['quantity']
      ..price = json['price']
      ..createdAt = json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null
      ..synced = true;
  }
}
