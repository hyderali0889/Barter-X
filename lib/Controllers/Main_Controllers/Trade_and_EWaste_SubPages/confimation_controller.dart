import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ConfirmationController extends GetxController {
  Rxn<QuerySnapshot<Map<String, dynamic>>> data =
      Rxn<QuerySnapshot<Map<String, dynamic>>>();
  RxBool isLoading = false.obs;

  void startLoading(bool val) {
    isLoading.value = val;
  }
  RxBool isLoading1= false.obs;

  void startLoading1(bool val) {
    isLoading1.value = val;
  }

  void addData(QuerySnapshot<Map<String, dynamic>> dat) {
    data.value = dat;
  }
}
