import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/Other_Controllers/auction_bid_details_controller.dart';

class AuctionBidDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuctionBidDetailsController());
  }
}
