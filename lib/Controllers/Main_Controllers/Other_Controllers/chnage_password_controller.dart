import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  RxBool isLoading = false.obs;
  startLoading(bool val) {
    isLoading.value = val;
  }
}
