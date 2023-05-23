import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Form_Controllers/auction_form_controller.dart';

class AuctionFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuctionFormController());
  }
}
