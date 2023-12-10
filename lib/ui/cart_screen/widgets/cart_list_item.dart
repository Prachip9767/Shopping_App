import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tech_verito_assignment/data/product_model.dart';
import 'package:tech_verito_assignment/ui/cart_screen/widgets/quntity_widget.dart';
import 'package:tech_verito_assignment/ui/product_controller.dart';

class CartListItems extends StatelessWidget{
 final List<ProductModel> item;
 final int index;
 final VoidCallback onTap;

  const CartListItems({super.key,required this.item,
  required this.index,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: kIsWeb ? 20 : double.maxFinite,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CachedNetworkImage(
                      imageUrl:
                      item[index].image ?? '',
                      fit: BoxFit.cover,
                      memCacheHeight: 50,
                      memCacheWidth: 50,
                      width: 50,
                      height: 50,
                      errorWidget: (context, str, dyn) =>
                      const Text('image Unavailable'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item[index].title ?? '',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Rs. ${item[index].price}',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed:
                        onTap,
                    child: const Text('Remove'),
                  ),
                  const SizedBox(width: 50),
                  QuantityWidget(
                    item: item,index: index,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}