import 'package:barter_x/Controllers/Main_Controllers/Other_Controllers/chnage_password_controller.dart';
import 'package:get/get.dart';


class ChangePasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChangePasswordController());
  }
}
