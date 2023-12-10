import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';

List<ProductModel> productsFromJson(String str) =>
List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));


class ProductModel{
  int? id;
  String? title;
  double? price;
  String? description;
  Category? category;
  String? image;
  Rating? rating;
  RxBool? isAddedToCart;
  RxInt? quantity;

  ProductModel({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    this.rating,
    this.isAddedToCart,
    this.quantity
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    quantity: 1.obs,
    isAddedToCart: false.obs,
    id: json["id"],
    title: json["title"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    category: categoryValues.map[json["category"]],
    image: json["image"],
    rating: json["rating"] != null ? Rating.fromJson(json["rating"]) : null,
  );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.id == id &&
        other.title == title &&
        other.price == price &&
        other.description == description &&
        other.category == category &&
        other.image == image &&
        other.rating == rating; // You might need to do a similar comparison inside Rating class as well
  }

  @override
  int get hashCode {
    return id.hashCode ^
    title.hashCode ^
    price.hashCode ^
    description.hashCode ^
    category.hashCode ^
    image.hashCode ^
    rating.hashCode; // Same note as above regarding Rating
  }
}

enum Category {
  ELECTRONICS,
  JEWELERY,
  MEN_S_CLOTHING,
  WOMEN_S_CLOTHING
}

final categoryValues = EnumValues({
  "electronics": Category.ELECTRONICS,
  "jewelery": Category.JEWELERY,
  "men's clothing": Category.MEN_S_CLOTHING,
  "women's clothing": Category.WOMEN_S_CLOTHING
});

class Rating {
  double? rate;
  int? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
    rate: json["rate"]?.toDouble(),
    count: json["count"],
  );
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rating &&
        other.rate == rate &&
        other.count == count;
  }

  @override
  int get hashCode => rate.hashCode ^ count.hashCode;
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