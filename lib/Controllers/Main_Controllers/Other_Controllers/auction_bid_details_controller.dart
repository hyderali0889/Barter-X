import 'package:get/get.dart';

class AuctionBidDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDone = false.obs;

  markDone(bool val) {
    isDone.value = val;
  }

  void startLoading(bool val) {
    isLoading.value = val;
  }
}
