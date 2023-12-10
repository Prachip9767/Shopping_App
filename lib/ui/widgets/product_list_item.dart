import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_verito_assignment/data/product_model.dart';

class ProductListItem extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback? onTap;
  final RxBool isAddedToTheCart;

  ProductListItem(
      {required this.productModel, required this.isAddedToTheCart, this.onTap,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                      imageUrl: productModel.image ?? '',
                      fit: BoxFit.cover,
                      memCacheHeight: 50,
                      memCacheWidth: 50,
                      width: 50,
                      height: 50,
                      placeholder: (context, url) => Container(color: Colors.grey),
                      errorWidget: (context, str, dyn) =>
                      const Text('image Unavailable')),
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
                      productModel.title ?? '',
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Rs. ${productModel.price}',
                        style:
                        const TextStyle(color: Colors.black, fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
          Row(
            children: [
              Flexible(
                child: Text(
                  productModel.description ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Obx(() {
                return ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue)),
                  onPressed: onTap,
                  child: !isAddedToTheCart.value
                      ? const Text('Add to cart')
                      : const Text('View Cart'),
                );
              })
            ],
          ),
        ],
      ),
    );
  }
}
