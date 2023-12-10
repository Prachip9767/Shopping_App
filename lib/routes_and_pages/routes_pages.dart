import 'package:get/get.dart';
import 'package:tech_verito_assignment/ui/login_screen/log_in_screen.dart';
import 'package:tech_verito_assignment/ui/login_screen/login_screen_binding.dart';
import 'package:tech_verito_assignment/ui/product_binding.dart';
import 'package:tech_verito_assignment/ui/product_view.dart';

class ProductPages{
  ProductPages._();

  static const initial =ProductRoutesPaths.productHome ;

  static final routes = <GetPage>[
    GetPage(
        name: ProductRoutesPaths.productHome,
        page: () =>const ProductView(),
        binding:ProductBinding()
    ),
    GetPage(name: ProductRoutesPaths.logInScreen,
        page: ()=>LogInScreen(),
      binding: LogInScreenBindings()
    )
  ];
}


abstract class ProductRoutesPaths {
  static const logInScreen = LogInScreen.routeName;
  static const productHome='/';

}