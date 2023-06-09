import 'dart:io';

import 'package:get/get.dart';

class TradeFormController extends GetxController {
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
}
