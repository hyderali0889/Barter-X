import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  RxBool isAdError = false.obs;
  RxString userPoints = "".obs;
  RxBool isProductinWishlist = false.obs;
  RxString productId = "".obs;

  void changeWishlist(bool val) {
    isProductinWishlist.value = val;
  }

  void addProductId(String id) {
    productId.value = id;
  }

  void setUserPoints(String point) {
    userPoints.value = point;
  }

  void changeAdError(bool value) {
    isAdError.value = value;
  }
}
