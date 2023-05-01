import 'package:get/get.dart';

class MainFormController extends GetxController {
  RxString selectedDistrict = "".obs;
  RxString selectedCat = "".obs;
  void selectDistrict(String district) {
    selectedDistrict.value = district;
  }

  void selectCat(String cat) {
    selectedCat.value = cat;
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
