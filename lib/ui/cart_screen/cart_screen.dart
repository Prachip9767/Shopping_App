import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_verito_assignment/ui/cart_screen/widgets/cart_list_item.dart';
import 'package:tech_verito_assignment/ui/product_controller.dart';
import 'package:tech_verito_assignment/utils/constants.dart';

class CartScreen extends GetView<ProductController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Obx(() {
        double totalCartValue = controller.cartItems.fold(0, (sum, item) {
          return sum + (item.price! * item.quantity!.value);
        });
        return controller.cartItems.isEmpty
            ? const Center(
          child: Text(Constants.emptyCartText),
        )
            : ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: controller.cartItems.length,
                  itemBuilder: (context, index) {
                    var item = controller.cartItems[index];
                    return CartListItems(item: controller.cartItems,
                        index: index,
                        onTap:() {
                          controller.updateAllProductsAfterCartItemRemoval(
                              item.id!);
                          controller.cartItems.remove(
                              item);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Item removed from the cart'),
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    children: [
                      Text(
                        'Total value: Rs. ${totalCartValue.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Checking out......'),
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.blue,
                            ),
                          );
                        },
                        child: const Text('Check Out '),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
