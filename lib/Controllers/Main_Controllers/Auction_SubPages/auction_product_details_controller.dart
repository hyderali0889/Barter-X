import 'package:get/get.dart';

class AuctionProductDetailsController extends GetxController {
  RxBool isAdError = false.obs;

  void changeAdError(bool value) {
    isAdError.value = value;
  }
}
