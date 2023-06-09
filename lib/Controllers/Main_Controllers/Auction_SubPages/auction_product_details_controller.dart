import 'package:get/get.dart';

class AuctionProductDetailsController extends GetxController {
  RxBool isAdError = false.obs;

  void changeAdError(bool value) {
    isAdError.value = value;
  }


  RxString userPoints = "".obs;
  RxBool isProductinWishlist = false.obs;
  RxString productId = "".obs;
 RxBool isLoading = false.obs;

  void startLoading(bool val) {
    isLoading.value = val;
  }

  void changeWishlist(bool val) {
    isProductinWishlist.value = val;
  }

  void addProductId(String id) {
    productId.value = id;
  }

  void setUserPoints(String point) {
    userPoints.value = point;
  }


}
