import 'package:foodapp/models/item%20model/item_model.dart';

extension ItemModelJson on ItemModel {
  /// FROM JSON
  static ItemModel fromJson(Map<String, dynamic> json) {
    return ItemModel()
      ..itemId = json['id'] as int
      ..categoryId = json['category_id'] as int
      ..name = json['name'] as String
      ..description = json['description'] as String
      ..price = (json['price'] as num).toDouble()
      ..imageUrl = json['image_url'] as String
      ..ingreidents = json['ingreident'] as String
      ..available = json['available'] as bool? ?? false
      ..createdAt = json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null;
  }

  /// TO JSON
  Map<String, dynamic> toJson() {
    return {
      'id': itemId,
      'category_id': categoryId,
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'ingredients': ingreidents,
      'available': available,
    };
  }
}
