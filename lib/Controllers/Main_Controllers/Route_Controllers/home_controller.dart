import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxString errorMsg =
      "We Encountered an error trying to log into your account. Please Check your Network Connection and try again."
          .obs;

  RxBool isRefreshing = false.obs;

  void refreshData(bool value) {
    isRefreshing.value = value;
  }

  Rxn<Future<QuerySnapshot<Map<String, dynamic>>>> data =
      Rxn<Future<QuerySnapshot<Map<String, dynamic>>>>();

  void addTradeData(Future<QuerySnapshot<Map<String, dynamic>>> da) {
    data.value = da;
  }

  changeErrorMessage(String errormsg) {
    errorMsg.value = errormsg;
  }

  RxBool errorOcurred = false.obs;
  void changeErrorStatus(bool errorStatus) {
    errorOcurred.value = errorStatus;
  }
}
