// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);
import 'dart:convert';

import 'package:get/get.dart';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  String objectId;
  String name;
  Category category;
  String quantity;
  String discountPercentage;
  String discountValue;
  String salePrice;
  String purchasePrice;
  String netValue;
  String manufacturer;
  String status;

  ProductsModel({
    required this.objectId,
    required this.name,
    required this.category,
    required this.quantity,
    required this.discountPercentage,
    required this.discountValue,
    required this.salePrice,
    required this.purchasePrice,
    required this.netValue,
    required this.manufacturer,
    required this.status,
  });

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        objectId: json["objectId"],
        name: json["name"],
        category: Category.fromJson(json["category"]),
        quantity: json["quantity"],
        discountPercentage: json["discountPercentage"],
        discountValue: json["discountValue"],
        salePrice: json["salePrice"],
        purchasePrice: json["purchasePrice"],
        netValue: json["netValue"],
        manufacturer: json["manufacturer"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "name": name,
        "category": category.toJson(),
        "quantity": quantity,
        "discountPercentage": discountPercentage,
        "discountValue": discountValue,
        "salePrice": salePrice,
        "purchasePrice": purchasePrice,
        "netValue": netValue,
        "manufacturer": manufacturer,
        "status": status,
      };

  static dynamic isSalePriceValid(String v1, String v2) {
    if (GetUtils.isNum(v2) || v1 != '' && v2 != '') {
      if (!GetUtils.isGreaterThan(int.parse(v2), int.parse(v1))) {
        return 'Sale price must be greater than purchase price';
      }
    } else {
      return 'Please enter numeric value';
    }
  }
}

class Category {
  String objectId;
  String categoryName;

  Category({
    required this.objectId,
    required this.categoryName,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        objectId: json["objectId"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() => {
        "objectId": objectId,
        "categoryName": categoryName,
      };
}
