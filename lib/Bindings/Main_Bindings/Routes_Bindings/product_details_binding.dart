import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Route_Controllers/product_details_controller.dart';

class ProductDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailsController());
  }
}
