import 'dart:io';

import 'package:get/get.dart';

class AuctionFormController extends GetxController {
  RxString selectedDistrict = "".obs;
  RxString selectedCat = "".obs;
  RxBool isLoading = false.obs;
  Rxn<File> image = Rxn<File>();

  void addImage(File img) {
    image.value = img;
  }

  void startLoading(bool data) {
    isLoading.value = data;
  }

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
