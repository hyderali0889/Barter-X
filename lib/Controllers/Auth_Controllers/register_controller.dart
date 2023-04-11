import 'package:get/get.dart';

class RegisterController extends GetxController {
   RxString errorMsg =
      "We Encountered an error trying to log into your account. Please Check your Network Connection and try again."
          .obs;

  changeErrorMessage(String errormsg) {
    errorMsg.value = errormsg;
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
