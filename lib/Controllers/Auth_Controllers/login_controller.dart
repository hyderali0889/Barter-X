import 'package:get/get.dart';

class LoginController extends GetxController {
  RxBool errorOcurred = false.obs;
  RxBool obsecureText = false.obs;

  void changeObsecureText(bool val) {
    obsecureText.value = val;
  }

  void changeErrorStatus(bool errorStatus) {
    errorOcurred.value = errorStatus;
  }
}
