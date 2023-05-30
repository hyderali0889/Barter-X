import 'package:get/get.dart';

class PhoneController extends GetxController {
  RxInt token = 0.obs;
  RxString verificationId = "".obs;

  void setVerID(String verId) {
    verificationId.value = verId;
  }

  void setToken(int toke) {
    token.value = toke;
  }

  RxBool obsecureText = false.obs;
  RxBool isLoading = false.obs;

  void startLoading(bool loading) {
    isLoading.value = loading;
  }

  void changeObsecureText(bool val) {
    obsecureText.value = val;
  }
}
