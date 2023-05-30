import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt selectedPage = 0.obs;

  void changePage(int page) {
    selectedPage.value = page;
  }
}
