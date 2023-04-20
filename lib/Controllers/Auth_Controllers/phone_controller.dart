import 'package:get/get.dart';

class PhoneController extends GetxController {
  RxBool isLoading1 = false.obs;
  RxInt token = 0.obs;
  RxString verificationId = "".obs;

  void setVerID(String verId) {
    print("This is the Id $verId");
    verificationId.value = verId;
  }

  void setToken(int toke) {
    print("This is the token $toke");

    token.value = toke;
  }

  RxString errorMsg =
      "We Encountered an error trying to log into your account. Please Check your Network Connection and try again."
          .obs;

  changeErrorMessage(String errormsg) {
    errorMsg.value = errormsg;
  }

  void startLoading1(bool loading) {
    isLoading1.value = loading;
  }

  RxBool errorOcurred = false.obs;
  RxBool obsecureText = false.obs;
  RxBool isLoading = false.obs;

  void startLoading(bool loading) {
    isLoading.value = loading;
  }

  void changeObsecureText(bool val) {
    obsecureText.value = val;
  }

  void changeErrorStatus(bool errorStatus) {
    errorOcurred.value = errorStatus;
  }
}
