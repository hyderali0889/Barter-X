
import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/EWaste_controller.dart';
import '../../../Controllers/Main_Controllers/Navigation_Controller/navigation_controller.dart';
import '../../../Controllers/Main_Controllers/auction_controller.dart';
import '../../../Controllers/Main_Controllers/home_controller.dart';
import '../../../Controllers/Main_Controllers/notification_controller.dart';
import '../../../Controllers/Main_Controllers/profile_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
     Get.lazyPut(() => HomeController());
        Get.lazyPut(() => AuctionController());
        Get.lazyPut(() => EWasteController());
        Get.lazyPut(() => NotificationController());
        Get.lazyPut(() => ProfileController());
  }

}
