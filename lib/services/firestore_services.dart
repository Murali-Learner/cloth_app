import 'dart:convert';
import 'dart:developer';

import 'package:cloth_app/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final collection = FirebaseFirestore.instance.collection("all_products");

  Future<List<ProductModel>> getFirestoreData() async {
    List<ProductModel> data =
        await collection.get().then((value) => value.docs.map((e) {
              return ProductModel.fromMap(e.data());
            }).toList());
    return data;
  }

  Future<List<ProductModel>> getSizeFilterProducts(
      List<String> individualFilterNames) async {
    log(individualFilterNames.length.toString());
    List<ProductModel> data = await collection
        .where("size", arrayContainsAny: individualFilterNames)
        .get()
        .then((value) {
      return value.docs.map((e) {
        return ProductModel.fromMap(e.data());
      }).toList();
    });
    log(data.toString());
    return data;
  }

  Future<List<ProductModel>> getFilterProducts(
      String filterName, List<String> individualFilterNames) async {
    List<ProductModel> data = await collection
        .where(filterName, whereIn: individualFilterNames)
        // .where("field")
        .get()
        .then((value) {
      return value.docs.map((e) {
        return ProductModel.fromMap(e.data());
      }).toList();
    });

    return data;
  }
}



/*
final String response =
        await rootBundle.loadString('assets/products_data.json');
    final data = await json.decode(response);
    log(data["all_products"].runtimeType.toString());

    for (var i = 0; i < data["all_products"].length; i++) {
      // log(data["all_products"][i]["price"].toString());
      prices.add(data["all_products"][i]["price"]);
    }
    // log(prices.to
   await firestore.collection("all_products").add({
    "id": id,
    'productName': title,
    'productUrl': imageUrl,
    'brand': brand,
    'price': price,
    "discount": discount,
    'size': size,
    'isFavorite': isFavorite,
  }).whenComplete(() {
    log("upload done");
    log('${firestore.collection("all_products")}');
  });
  /* {    "size": ["S", "M", "L"], "price": ₹579, discount: 20%, id: 27, productUrl: https://rukminim1.flixcart.com/image/832/832/l3os4280/t-shirt/7/1/9/xl-st-navy-maroon-grey-smartees-original-imageqgrukakzcb8.jpeg?q=70, brand: Smartees, productName: Color Block Men Round Neck Maroon, Grey T-Shirt, isFavorite: false} */
   */
