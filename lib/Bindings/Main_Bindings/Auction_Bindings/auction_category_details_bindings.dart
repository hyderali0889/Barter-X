import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Auction_SubPages/auction_category_details_controller.dart';

class AuctionCategoryDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuctionCategoryDetailsController());
  }
}
