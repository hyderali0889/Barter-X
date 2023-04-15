import 'package:barter_x/Controllers/Auth_Controllers/phone_controller.dart';
import 'package:get/get.dart';

class PhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneController());
  }
}
