import 'package:isar/isar.dart';

part 'category_model.g.dart';

@collection
class CategoryModel {
  Id id = Isar.autoIncrement;

  late int categoryId;
  late String name;
  DateTime? createdAt;
}
