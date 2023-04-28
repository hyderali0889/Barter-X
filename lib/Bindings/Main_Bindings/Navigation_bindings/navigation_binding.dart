
import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Route_Controllers/ewaste_controller.dart';
import '../../../Controllers/Main_Controllers/Navigation_Controller/navigation_controller.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/auction_controller.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/home_controller.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/notification_controller.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/profile_controller.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/wallet_controller.dart';


class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
     Get.lazyPut(() => HomeController());
        Get.lazyPut(() => AuctionController());
        Get.lazyPut(() => EWasteController());
        Get.lazyPut(() => WalletController());
        Get.lazyPut(() => NotificationController());
        Get.lazyPut(() => ProfileController());
  }

}
