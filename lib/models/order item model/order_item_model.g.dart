// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetOrderItemModelCollection on Isar {
  IsarCollection<OrderItemModel> get orderItemModels => this.collection();
}

const OrderItemModelSchema = CollectionSchema(
  name: r'OrderItemModel',
  id: 3320497907544385651,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'itemId': PropertySchema(
      id: 1,
      name: r'itemId',
      type: IsarType.long,
    ),
    r'localOrderId': PropertySchema(
      id: 2,
      name: r'localOrderId',
      type: IsarType.long,
    ),
    r'orderId': PropertySchema(
      id: 3,
      name: r'orderId',
      type: IsarType.long,
    ),
    r'orderItemId': PropertySchema(
      id: 4,
      name: r'orderItemId',
      type: IsarType.long,
    ),
    r'price': PropertySchema(
      id: 5,
      name: r'price',
      type: IsarType.double,
    ),
    r'quantity': PropertySchema(
      id: 6,
      name: r'quantity',
      type: IsarType.long,
    ),
    r'synced': PropertySchema(
      id: 7,
      name: r'synced',
      type: IsarType.bool,
    )
  },
  estimateSize: _orderItemModelEstimateSize,
  serialize: _orderItemModelSerialize,
  deserialize: _orderItemModelDeserialize,
  deserializeProp: _orderItemModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _orderItemModelGetId,
  getLinks: _orderItemModelGetLinks,
  attach: _orderItemModelAttach,
  version: '3.1.0+1',
);

int _orderItemModelEstimateSize(
  OrderItemModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _orderItemModelSerialize(
  OrderItemModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeLong(offsets[1], object.itemId);
  writer.writeLong(offsets[2], object.localOrderId);
  writer.writeLong(offsets[3], object.orderId);
  writer.writeLong(offsets[4], object.orderItemId);
  writer.writeDouble(offsets[5], object.price);
  writer.writeLong(offsets[6], object.quantity);
  writer.writeBool(offsets[7], object.synced);
}

OrderItemModel _orderItemModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = OrderItemModel();
  object.createdAt = reader.readDateTimeOrNull(offsets[0]);
  object.id = id;
  object.itemId = reader.readLong(offsets[1]);
  object.localOrderId = reader.readLongOrNull(offsets[2]);
  object.orderId = reader.readLongOrNull(offsets[3]);
  object.orderItemId = reader.readLongOrNull(offsets[4]);
  object.price = reader.readDouble(offsets[5]);
  object.quantity = reader.readLong(offsets[6]);
  object.synced = reader.readBool(offsets[7]);
  return object;
}

P _orderItemModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readDouble(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _orderItemModelGetId(OrderItemModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _orderItemModelGetLinks(OrderItemModel object) {
  return [];
}

void _orderItemModelAttach(
    IsarCollection<dynamic> col, Id id, OrderItemModel object) {
  object.id = id;
}

extension OrderItemModelQueryWhereSort
    on QueryBuilder<OrderItemModel, OrderItemModel, QWhere> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension OrderItemModelQueryWhere
    on QueryBuilder<OrderItemModel, OrderItemModel, QWhereClause> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension OrderItemModelQueryFilter
    on QueryBuilder<OrderItemModel, OrderItemModel, QFilterCondition> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'itemId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'itemId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'itemId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      itemIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'itemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      localOrderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'localOrderId',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      localOrderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'localOrderId',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      localOrderIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localOrderId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      localOrderIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localOrderId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      localOrderIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localOrderId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      localOrderIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localOrderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'orderId',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'orderId',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderItemIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'orderItemId',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderItemIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'orderItemId',
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderItemIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'orderItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderItemIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'orderItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderItemIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'orderItemId',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      orderItemIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'orderItemId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      priceEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      priceGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      priceLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'price',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      priceBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'price',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantity',
        value: value,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      quantityBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantity',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterFilterCondition>
      syncedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'synced',
        value: value,
      ));
    });
  }
}

extension OrderItemModelQueryObject
    on QueryBuilder<OrderItemModel, OrderItemModel, QFilterCondition> {}

extension OrderItemModelQueryLinks
    on QueryBuilder<OrderItemModel, OrderItemModel, QFilterCondition> {}

extension OrderItemModelQuerySortBy
    on QueryBuilder<OrderItemModel, OrderItemModel, QSortBy> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByLocalOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localOrderId', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByLocalOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localOrderId', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByOrderItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderItemId', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByOrderItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderItemId', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> sortBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      sortBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }
}

extension OrderItemModelQuerySortThenBy
    on QueryBuilder<OrderItemModel, OrderItemModel, QSortThenBy> {
  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'itemId', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByLocalOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localOrderId', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByLocalOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localOrderId', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByOrderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderId', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByOrderItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderItemId', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByOrderItemIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'orderItemId', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByPriceDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'price', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenByQuantityDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quantity', Sort.desc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy> thenBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.asc);
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QAfterSortBy>
      thenBySyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'synced', Sort.desc);
    });
  }
}

extension OrderItemModelQueryWhereDistinct
    on QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> {
  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'itemId');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByLocalOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localOrderId');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByOrderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderId');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct>
      distinctByOrderItemId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'orderItemId');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByPrice() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'price');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctByQuantity() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quantity');
    });
  }

  QueryBuilder<OrderItemModel, OrderItemModel, QDistinct> distinctBySynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'synced');
    });
  }
}

extension OrderItemModelQueryProperty
    on QueryBuilder<OrderItemModel, OrderItemModel, QQueryProperty> {
  QueryBuilder<OrderItemModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<OrderItemModel, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<OrderItemModel, int, QQueryOperations> itemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'itemId');
    });
  }

  QueryBuilder<OrderItemModel, int?, QQueryOperations> localOrderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localOrderId');
    });
  }

  QueryBuilder<OrderItemModel, int?, QQueryOperations> orderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderId');
    });
  }

  QueryBuilder<OrderItemModel, int?, QQueryOperations> orderItemIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'orderItemId');
    });
  }

  QueryBuilder<OrderItemModel, double, QQueryOperations> priceProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'price');
    });
  }

  QueryBuilder<OrderItemModel, int, QQueryOperations> quantityProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quantity');
    });
  }

  QueryBuilder<OrderItemModel, bool, QQueryOperations> syncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'synced');
    });
  }
}
