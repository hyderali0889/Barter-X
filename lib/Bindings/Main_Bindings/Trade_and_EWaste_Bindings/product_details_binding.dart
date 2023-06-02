import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Trade_and_EWaste_SubPages/product_details_controller.dart';

class ProductDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailsController());
  }
}
