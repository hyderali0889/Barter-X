import 'package:get/get.dart';

class OTPController extends GetxController {
  RxBool isLoading1 = false.obs;

  void startLoading1(bool loading) {
    isLoading1.value = loading;
  }

  RxBool isLoading2 = false.obs;

  void startLoading2(bool loading) {
    isLoading2.value = loading;
  }

  RxString errorMsg =
      "We Encountered an error trying to log into your account. Please Check your Network Connection and try again."
          .obs;

  changeErrorMessage(String errormsg) {
    errorMsg.value = errormsg;
  }

  RxBool errorOcurred = false.obs;
  void changeErrorStatus(bool errorStatus) {
    errorOcurred.value = errorStatus;
  }
}
