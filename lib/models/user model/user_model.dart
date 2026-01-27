import 'package:isar/isar.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;

  late String authID;
  late String name;
  late String role;
  String? phoneNumber;
  String? imageUrl;
  String? address;
  DateTime? createdAt;
  int buyingPoints = 0;
  bool blocked = false;
}
