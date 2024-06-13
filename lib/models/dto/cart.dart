import 'dart:convert';

import 'package:attendance/models/dto/product.dart';

class CartItem extends Product {
  int itemQuantity;
  CartItem({
    required super.id,
    required super.imagefrontsmallurl,
    required super.imagefronturl,
    required super.productname,
    required super.quantity,
    required super.price,
    required super.categories,
    required this.itemQuantity,
  });

  // ---------------------------------------------------------------------------
  // JSON
  // ---------------------------------------------------------------------------

  factory CartItem.fromRawJson(String str) =>
      CartItem.fromMap(json.decode(str));

  @override
  String toRawJson() => json.encode(toMap());

  // ---------------------------------------------------------------------------
  // Maps
  // ---------------------------------------------------------------------------

  factory CartItem.fromMap(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'],
      imagefrontsmallurl: json['image_front_small_url'],
      imagefronturl: json['imagefronturl'],
      productname: json['product_name'],
      quantity: json['quantity'],
      price: json['price'],
      itemQuantity: json['itemQuantity'],
      categories: json['categories'],
    );
  }
  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_front_small_url'] = imagefrontsmallurl;
    data['imagefronturl'] = imagefronturl;
    data['product_name'] = productname;
    data['quantity'] = quantity;
    data['price'] = price;
    data['itemQuantity'] = itemQuantity;
    data['categories'] = categories;
    return data;
  }
}
