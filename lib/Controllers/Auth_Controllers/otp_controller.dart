import 'package:get/get.dart';

class OTPController extends GetxController {
  RxBool isLoading1 = false.obs;

  void startLoading1(bool loading) {
    isLoading1.value = loading;
  }
}
