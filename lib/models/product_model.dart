// To parse this JSON data, do
//
//     final productModel = productModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class ProductModel {
  ProductModel({
    required this.size,
    required this.price,
    required this.discount,
    required this.id,
    required this.productUrl,
    required this.brand,
    required this.productName,
    required this.isFavorite,
  });

  List<String> size;
  String price;
  String discount;
  String id;
  String productUrl;
  String brand;
  String productName;
  bool isFavorite;

  ProductModel copyWith({
    List<String>? size,
    String? price,
    String? discount,
    String? id,
    String? productUrl,
    String? brand,
    String? productName,
    bool? isFavorite,
  }) =>
      ProductModel(
        size: size ?? this.size,
        price: price ?? this.price,
        discount: discount ?? this.discount,
        id: id ?? this.id,
        productUrl: productUrl ?? this.productUrl,
        brand: brand ?? this.brand,
        productName: productName ?? this.productName,
        isFavorite: isFavorite ?? this.isFavorite,
      );

  factory ProductModel.fromJson(String str) =>
      ProductModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductModel.fromMap(Map<String, dynamic> json) => ProductModel(
        size: List<String>.from(json["size"].map((x) => x)),
        price: json["price"],
        discount: json["discount"],
        id: json["id"],
        productUrl: json["productUrl"],
        brand: json["brand"],
        productName: json["productName"],
        isFavorite: json["isFavorite"],
      );

  Map<String, dynamic> toMap() => {
        "size": List<dynamic>.from(size.map((x) => x)),
        "price": price,
        "discount": discount,
        "id": id,
        "productUrl": productUrl,
        "brand": brand,
        "productName": productName,
        "isFavorite": isFavorite,
      };
}


// * {    "size": ["S", "M", "L"], "price": "₹579", "discount": "20%", "id": "27", "productUrl": "https://rukminim1.flixcart.com/image/832/832/l3os4280/t-shirt/7/1/9/xl-st-navy-maroon-grey-smartees-original-imageqgrukakzcb8.jpeg?q=70", "brand": "Smartees", "productName": "Color Block Men Round Neck Maroon, Grey T-Shirt", "isFavorite": "false"} */
