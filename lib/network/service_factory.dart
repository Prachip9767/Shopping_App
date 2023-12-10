import 'dart:convert';

import 'package:tech_verito_assignment/data/product_model.dart';
import 'package:http/http.dart' as http;

class ServiceFactory {

  static Future<List<ProductModel>> fetchProductList() async {
    try {
      var response = await http.get(Uri.parse(
          'https://run.mocky.io/v3/adfee416-587d-411a-9bc3-3038167bfb81'));

      if (response.statusCode == 200) {
        var jsonString = response.body;
        return productsFromJson(jsonString);
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching product list: $e');
      throw e;
    }
  }
}