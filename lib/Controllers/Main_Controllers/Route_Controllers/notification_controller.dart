import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  RxInt selectedPill = 0.obs;
  RxInt walletPoints = 0.obs;

  RxBool isAdError = false.obs;

  RxList<dynamic> data = [].obs;

  void addToData(QuerySnapshot<Map<String, dynamic>> dat) {
    data.add(dat);
  }

  void resetData() {
    data.value = [];
  }

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
