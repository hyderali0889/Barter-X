import 'package:get/get.dart';

class ProfileController extends GetxController {
  RxBool isAdError = false.obs;
  RxString userPoints = "0".obs;

  void setUserPoints(String points) {
    userPoints.value = points;
  }

  void changeAdError(bool value) {
    isAdError.value = value;
  }
}
