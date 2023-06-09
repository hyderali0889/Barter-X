import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Form_Controllers/bid_form_controller.dart';

class BidFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BidFormController());
  }
}
