import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Form_Controllers/trade_form_controller.dart';

class TradeFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TradeFormController());
  }
}
