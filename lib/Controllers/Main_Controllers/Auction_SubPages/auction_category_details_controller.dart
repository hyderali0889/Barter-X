import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuctionCategoryDetailsController extends GetxController {
  RxBool isAdError = false.obs;

  void changeAdError(bool value) {
    isAdError.value = value;
  }

   RxBool isRefreshing = false.obs;

  void refreshData(bool value) {
    isRefreshing.value = value;
  }

  Rxn<Future<QuerySnapshot<Map<String, dynamic>>>> data =
      Rxn<Future<QuerySnapshot<Map<String, dynamic>>>>();

  void addTradeData(Future<QuerySnapshot<Map<String, dynamic>>> da) {
    data.value = da;
  }
}
