import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  RxBool isAdError = false.obs;

  void changeAdError(bool value) {
    isAdError.value = value;
  }
}
