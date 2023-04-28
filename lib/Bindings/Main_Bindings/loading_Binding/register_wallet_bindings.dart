

import 'package:get/get.dart';

import '../../../Controllers/Main_Controllers/loading_Controllers/register_wallet_controller.dart';

class RegisterWalletBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterWalletController());
  }
}
