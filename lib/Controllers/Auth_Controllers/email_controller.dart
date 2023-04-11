import 'package:get/get.dart';

class EmailController extends GetxController{
   RxBool isLoading1 = false.obs;
   RxBool isLoading2 = false.obs;

  void startLoading1(bool loading) {
    isLoading1.value = loading;
  }
  void startLoading2(bool loading) {
    isLoading2.value = loading;
  }
 }