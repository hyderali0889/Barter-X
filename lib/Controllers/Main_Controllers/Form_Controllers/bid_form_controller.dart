import 'dart:io';

import 'package:get/get.dart';

class BidFormController extends GetxController {

  RxBool isLoading = false.obs;
  Rxn<File> image = Rxn<File>();

  void addImage(File img) {
    image.value = img;
  }

  void startLoading(bool data) {
    isLoading.value = data;
  }


}
