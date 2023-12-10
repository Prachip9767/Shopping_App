import 'package:get/get.dart';
import 'package:tech_verito_assignment/ui/login_screen/login_screen_controller.dart';

class LogInScreenBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LogInScreenController>(() => LogInScreenController());
  }

}