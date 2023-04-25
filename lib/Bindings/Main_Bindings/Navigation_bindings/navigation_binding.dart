
import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Navigation_Controller/navigation_controller.dart';
import '../../../Controllers/Main_Controllers/notification_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NotificationController());
    Get.lazyPut(() => NavigationController());
  }
}
