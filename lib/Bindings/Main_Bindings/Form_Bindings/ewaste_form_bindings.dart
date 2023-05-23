import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Form_Controllers/ewaste_form_controller.dart';

class EWasteFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EWasteFormController());
  }
}
