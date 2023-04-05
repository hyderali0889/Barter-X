import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool errorOcurred = false.obs;

  void changeErrorStatus(bool errorStatus) {
    errorOcurred.value = errorStatus;
  }
}
