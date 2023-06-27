import 'package:get/get.dart';

class RatingsController extends GetxController {
  Rx<num> value = 0.0.obs;
  RxBool isLoading = false.obs;

  startLoading(bool load) {
    isLoading.value = load;
  }

  setvalue(num val) {
    value.value = val;
  }
}
