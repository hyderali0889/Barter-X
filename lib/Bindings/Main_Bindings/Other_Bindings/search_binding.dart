import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Other_Controllers/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
