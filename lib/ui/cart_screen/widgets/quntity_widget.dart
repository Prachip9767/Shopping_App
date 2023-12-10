import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tech_verito_assignment/data/product_model.dart';

class QuantityWidget extends StatelessWidget {
  final List<ProductModel> item;
  final int index;

  const QuantityWidget({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Row(
        children: [
          IconButton(
            onPressed: () {
              item[index].quantity?.value++;
            },
            icon: const Icon(Icons.add),
          ),
          Text(
            item[index].quantity?.value.toString() ?? '',
          ),
          IconButton(
            onPressed: item[index].quantity!.value > 1
                ? () {
              item[index].quantity?.value--;
            }
                : null,
            icon: Icon(
              Icons.remove,
              color: item[index].quantity!.value > 1
                  ? Colors.black
                  : Colors.grey,
            ),
          ),
        ],
      );
    });
  }

}