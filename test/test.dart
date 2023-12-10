import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tech_verito_assignment/data/product_model.dart';

void main() {
  group('ProductModel test cases', () {
    final json = '''
        {
          "id": 1,
          "title": "Product Title",
          "price": 10.99,
          "description": "Product Description",
          "category": "electronics",
          "image": "product_image.png",
          "rating": {
            "rate": 4.5,
            "count": 100
          }
        }
      ''';

    final Map<String, dynamic> jsonMap = jsonDecode(json);

    test('fromJson() should correctly deserialize JSON', () {
      final Map<String, dynamic> jsonMap = jsonDecode(json);
      final product = ProductModel.fromJson(jsonMap);

      expect(product.id, equals(1));
      expect(product.title, equals("Product Title"));
      expect(product.price, equals(10.99));
      expect(product.description, equals("Product Description"));
      expect(product.category, equals(Category.ELECTRONICS));
      expect(product.image, equals("product_image.png"));
      Rating expectedRating = Rating(rate: 4.5, count: 100);
      expect(product.rating?.rate, equals(expectedRating.rate));
      expect(product.rating?.count, equals(expectedRating.count));
    });

    test('fromJson() should set default values for missing or null values', () {
      final json = '{}';

      final Map<String, dynamic> jsonMap = jsonDecode(json);

      final product = ProductModel.fromJson(jsonMap);

      expect(product.id, isNull);
      expect(product.title, isNull);
      expect(product.price, isNull);
      expect(product.description, isNull);
      expect(product.category, isNull);
      expect(product.image, isNull);
      expect(product.rating, isNull);
    });

    test('instances with the same properties should be equal', () {
      final product1 = ProductModel.fromJson(jsonMap);

      final product2 = ProductModel(
        id: 1,
        title: "Product Title",
        price: 10.99,
        description: "Product Description",
        category: Category.ELECTRONICS,
        image: "product_image.png",
        rating: Rating(rate: 4.5, count: 100),
      );

      expect(product1, equals(product2));
    });

    test('instances with different properties should not be equal', () {
      final jsonMap2 = {
        "id": 2,
        "title": "Other Product",
        "price": 19.99,
        "description": "Other Description",
        "category": "jewelery",
        "image": "other_image.png",
        "rating": {
          "rate": 3.0,
          "count": 50
        },
      };

      final product1 = ProductModel.fromJson(jsonMap);
      final product2 = ProductModel.fromJson(jsonMap2);

      expect(product1, isNot(equals(product2)));
    });
  });
}
