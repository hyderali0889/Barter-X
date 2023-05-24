import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt selectedPage = 0.obs;

  void changePage(int page) {
    selectedPage.value = page;
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