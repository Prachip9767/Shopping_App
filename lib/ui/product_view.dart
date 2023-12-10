import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:tech_verito_assignment/ui/cart_screen/cart_screen.dart';
import 'package:tech_verito_assignment/ui/cart_screen/widgets/quntity_widget.dart';
import 'package:tech_verito_assignment/ui/product_controller.dart';
import 'package:tech_verito_assignment/utils/constants.dart';
import 'widgets/product_list_item.dart';

class ProductView extends GetView<ProductController> {
  const ProductView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(Constants.appName),
        actions: [
          GestureDetector(
            onTap: () => Get.to(() => CartScreen()),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.shopping_cart,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: Obx(() =>
        controller.isLoading.isTrue?
        const Center(
            child: CircularProgressIndicator(),
          )
        : controller.allProducts.isEmpty?const Center(
            child: Text(Constants.emptyProductListText)):
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: kIsWeb ? 3 : 1,
                childAspectRatio: 50 / 22,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: controller.displayedProducts.length
                  + (controller.isMoreDataLoading.value ? 1 : 0),
              controller: controller.scrollController,
              itemBuilder: (context, index) {
                if (index < controller.displayedProducts.length) {
                  final product = controller.allProducts[index];
                  return ProductListItem(
                    // counterWidget: QuantityWidget(item: controller.allProducts,
                    //     index: index),
                    isAddedToTheCart: product.isAddedToCart!,
                    productModel: product,
                    onTap: () {
                      if (!product.isAddedToCart!.value) {
                        product.isAddedToCart?.value = true;
                        controller.addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item added to the cart'),
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.blue,
                            behavior: SnackBarBehavior.fixed,
                          ),
                        );
                      } else {
                        Get.to(() => CartScreen());
                      }
                    },
                  );
                } else if (
                controller.displayedProducts.isNotEmpty &&
                    controller.isMoreDataLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
    )));
        }
}


