import 'package:get/get.dart';

class AuctionController extends GetxController {
  RxString errorMsg =
      "We Encountered an error trying to log into your account. Please Check your Network Connection and try again."
          .obs;

           RxBool isAdError = false.obs;

  void changeAdError(bool value) {
    isAdError.value = value;
  }

  changeErrorMessage(String errormsg) {
    errorMsg.value = errormsg;
  }

  RxBool errorOcurred = false.obs;
  void changeErrorStatus(bool errorStatus) {
    errorOcurred.value = errorStatus;
  }
}