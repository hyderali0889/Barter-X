import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxInt selectedPill = 0.obs;

  changePill(int val) {
    selectedPill.value = val;
  }
}
