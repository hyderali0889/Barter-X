import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Trade_and_EWaste_SubPages/ratings_controller.dart';

class RatingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RatingsController());
  }
}
