import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_verito_assignment/data/product_model.dart';
import 'package:tech_verito_assignment/network/service_factory.dart';
import 'package:tech_verito_assignment/routes_and_pages/routes_pages.dart';

class ProductController extends GetxController{

  final RxBool isLoading = true.obs;
  final RxList<ProductModel> allProducts = <ProductModel>[].obs;
  final RxList<ProductModel> displayedProducts = <ProductModel>[].obs;
  final RxList<ProductModel> cartItems = <ProductModel>[].obs;
  final ScrollController scrollController = ScrollController();
  final RxBool isMoreDataLoading = false.obs;
  final int limit = kIsWeb ? 15 : 5;
  int currentPage = 1;


  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    getData();
  }
  void _scrollListener() {
      loadNextPage();
  }
  getData() async {
    try {
      isLoading.value = true;
      var productList = await ServiceFactory.fetchProductList();
      allProducts.value = productList;
      loadNextPage();
        } finally {
      isLoading.value = false;
    }
  }
  void loadNextPage() {
    if (!isMoreDataLoading.value && currentPage * limit < allProducts.length) {
      isMoreDataLoading.value = true;
      currentPage++;
      int startIndex = (currentPage - 1) * limit;
      int endIndex = min(startIndex + limit, allProducts.length);
      Future.delayed(const Duration(seconds: 2), () {
        displayedProducts.addAll(allProducts.sublist(startIndex, endIndex));
        isMoreDataLoading.value = false;
      });
    }
  }
  void addToCart(ProductModel item) {
    if (!cartItems.contains(item)) {
      cartItems.add(item);
    }
  }

  void updateAllProductsAfterCartItemRemoval(int removedItemId) {
    int index = allProducts.indexWhere((product) => product.id == removedItemId);

    if (index != -1 && index < allProducts.length) {
      allProducts[index].quantity?.value = 1;
      allProducts[index].isAddedToCart!.value = false;
    } else {
      if (index == -1) {
        print('Item not found.');
      } else {
        print('Index out of range: $index');
      }
    }
  }


  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}