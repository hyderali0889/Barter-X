import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Auction_SubPages/auction_product_details_controller.dart';

class AuctionProductDetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuctionProductDetailsController());
  }
}
