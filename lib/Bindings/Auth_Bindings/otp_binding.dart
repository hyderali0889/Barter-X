import 'package:barter_x/Controllers/Auth_Controllers/otp_controller.dart';
import 'package:get/get.dart';

import '../../Controllers/Auth_Controllers/phone_controller.dart';

class OTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OTPController());
    Get.lazyPut(() => PhoneController());

  }
}
