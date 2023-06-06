import 'package:get/get.dart';

class RatingsController extends GetxController {
  RxDouble value = 0.0.obs;
  RxBool isLoading = false.obs;

  startLoading(bool load) {
    isLoading.value = load;
  }

  setvalue(double val) {
    value.value = val;
  }
}
