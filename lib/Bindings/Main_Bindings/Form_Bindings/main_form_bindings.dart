import 'package:get/get.dart';
import '../../../Controllers/Main_Controllers/Form_Controllers/main_form_controller.dart';

class MainFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainFormController());
  }
}
