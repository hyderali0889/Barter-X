import 'package:get/get.dart';

class EmailController extends GetxController {
  RxBool isLoading1 = false.obs;
  RxBool isLoading2 = false.obs;
  RxBool isLoading3 = false.obs;
  Rx<Duration> myDuration = const Duration(seconds: 30).obs;
  RxBool isTimerRunning = false.obs;

  startTimer(bool val) {
    isTimerRunning.value = val;
  }

  changeDuration(Duration newDuration) {
    myDuration.value = newDuration;
  }

  void startLoading1(bool loading) {
    isLoading1.value = loading;
  }

  void startLoading2(bool loading) {
    isLoading2.value = loading;
  }

  void startLoading3(bool loading) {
    isLoading3.value = loading;
  }
}
