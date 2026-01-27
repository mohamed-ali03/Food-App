import 'package:isar/isar.dart';

part 'item_model.g.dart';

@collection
class ItemModel {
  Id id = Isar.autoIncrement;

  late int itemId;
  late int categoryId;
  late String name;
  late String description;
  late double price;
  late String imageUrl;
  late String ingreidents;
  late bool available = false;
  late bool selected = true;
  DateTime? createdAt;
}
