import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Trade_and_EWaste_SubPages/confimation_controller.dart';

class ConfirmationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ConfirmationController());
  }
}
