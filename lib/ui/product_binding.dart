import 'package:get/get.dart';
import 'package:tech_verito_assignment/ui/product_controller.dart';
class ProductBinding extends Bindings{
  @override
  void dependencies() {
  Get.lazyPut<ProductController>(() => ProductController());
  }

}