import 'package:get/get.dart';

class SearchController extends GetxController {
  RxBool isSearchStarted = false.obs;

  startSearch(bool val) {
    isSearchStarted.value = val;
  }
}
