import 'package:barter_x/Controllers/Auth_Controllers/email_controller.dart';
import 'package:get/get.dart';

class EmailVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmailController());
  }
}
