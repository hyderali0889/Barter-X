import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxInt selectedPill = 0.obs;
  RxInt walletPoints = 0.obs;

  initWallet(int val) {
    walletPoints.value = val;
  }

  changePill(int val) {
    selectedPill.value = val;
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
