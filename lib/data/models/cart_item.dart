import 'dart:convert';

import 'package:nike/data/models/product.dart';

class CartItemEntity {
  final ProductEntity productEntity;
  final int id;
  final int count;

  CartItemEntity(this.productEntity, this.id, this.count);
  CartItemEntity.fromJson(Map<String, dynamic> json)
      : productEntity = ProductEntity.fromJson(json),
        id = json['id'],
        count = json['count'];
}
