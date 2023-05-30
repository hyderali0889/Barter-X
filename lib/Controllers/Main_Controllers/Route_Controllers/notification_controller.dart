import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxInt selectedPill = 0.obs;
  RxInt walletPoints = 0.obs;

  RxBool isAdError = false.obs;

  void changeAdError(bool value) {
    isAdError.value = value;
  }

  initWallet(int val) {
    walletPoints.value = val;
  }

  changePill(int val) {
    selectedPill.value = val;
  }
}
