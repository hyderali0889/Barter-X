import 'package:get/get.dart';

class RegisterController extends GetxController {
  RxBool obsecureText = false.obs;
  RxBool isLoading = false.obs;

  void startLoading(bool loading) {
    isLoading.value = loading;
  }

  void changeObsecureText(bool val) {
    obsecureText.value = val;
  }
}
