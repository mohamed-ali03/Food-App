import 'package:foodapp/models/category%20model/category_model.dart';

extension CategoryModelJson on CategoryModel {
  /// FROM JSON
  static CategoryModel fromJson(Map<String, dynamic> json) {
    return CategoryModel()
      ..categoryId = json['id'] as int
      ..name = json['name'] as String
      ..createdAt = json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null;
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {'id': categoryId, 'name': name};
  }
}
