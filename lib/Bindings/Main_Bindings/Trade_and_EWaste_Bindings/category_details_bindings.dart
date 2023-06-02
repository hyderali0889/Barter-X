import 'package:barter_x/Controllers/Main_Controllers/Trade_and_EWaste_SubPages/category_details_controller.dart';
import 'package:get/get.dart';

class CategoryDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryDetailsController());
  }
}
