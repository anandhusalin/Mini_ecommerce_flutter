// To parse this JSON data, do
//
//     final buttomyModel = buttomyModelFromJson(jsonString);

import 'dart:convert';

ButtomyModel buttomyModelFromJson(String str) =>
    ButtomyModel.fromJson(json.decode(str));

String buttomyModelToJson(ButtomyModel data) => json.encode(data.toJson());

class ButtomyModel {
  ButtomyModel({
    this.status,
    this.data,
    this.categoriesCount,
  });

  String? status;
  List<Datum>? data;
  int? categoriesCount;

  factory ButtomyModel.fromJson(Map<String, dynamic> json) => ButtomyModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        categoriesCount: json["categories_count"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "categories_count": categoriesCount,
      };
}

class Datum {
  Datum({
    this.categoryId,
    this.categoryName,
    this.products,
  });

  int? categoryId;
  String? categoryName;
  List<Product>? products;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categoryId: json["category_id"],
        categoryName: json["category_name"],
        products: json["products"] == null
            ? []
            : List<Product>.from(
                json["products"]!.map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "category_id": categoryId,
        "category_name": categoryName,
        "products": products == null
            ? []
            : List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.cartCount,
    this.kitchenItemId,
    this.kitchenItemName,
    this.kitchenItemImage,
    this.kitchenItemAmount,
    this.itemDiscountPrice,
  });

  int? cartCount;
  int? kitchenItemId;
  String? kitchenItemName;
  List<KitchenItemImage>? kitchenItemImage;
  int? kitchenItemAmount;

  int? itemDiscountPrice;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        cartCount: json['cart_count'],
        kitchenItemId: json["kitchen_item_id"],
        kitchenItemName: json["kitchen_item_name"],
        kitchenItemImage: json["kitchen_item_image"] == null
            ? []
            : List<KitchenItemImage>.from(json["kitchen_item_image"]!
                .map((x) => KitchenItemImage.fromJson(x))),
        kitchenItemAmount: json["kitchen_item_amount"],
        itemDiscountPrice: json["item_discount_price"],
      );

  Map<String, dynamic> toJson() => {
        'cart_count': cartCount,
        "kitchen_item_id": kitchenItemId,
        "kitchen_item_name": kitchenItemName,
        "kitchen_item_image": kitchenItemImage == null
            ? []
            : List<dynamic>.from(kitchenItemImage!.map((x) => x.toJson())),
        "kitchen_item_amount": kitchenItemAmount,
        "item_discount_price": itemDiscountPrice,
      };
}

enum Busaddress { NEAR_BRIDGE }

final busaddressValues = EnumValues({"Near Bridge": Busaddress.NEAR_BRIDGE});

class KitchenItemImage {
  KitchenItemImage({
    this.images,
  });

  String? images;

  factory KitchenItemImage.fromJson(Map<String, dynamic> json) =>
      KitchenItemImage(
        images: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "images": images,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
