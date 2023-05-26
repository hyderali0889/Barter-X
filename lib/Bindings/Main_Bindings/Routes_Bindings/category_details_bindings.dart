import 'package:barter_x/Controllers/Main_Controllers/Route_Controllers/category_details_controller.dart';
import 'package:get/get.dart';

class CategoryDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDetailsController());
  }
}
