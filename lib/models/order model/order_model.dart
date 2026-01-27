import 'package:isar/isar.dart';

part 'order_model.g.dart';

@collection
class OrderModel {
  Id id = Isar.autoIncrement;

  int? orderId;
  late String userId;
  late String status;
  late double totalPrice;
  late String address;
  late bool synced;
  String? message;
  DateTime? createdAt;
}
