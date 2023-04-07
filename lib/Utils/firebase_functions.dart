import 'dart:async';

import 'package:barter_x/Controllers/Auth_Controllers/login_controller.dart';
import 'package:barter_x/Controllers/Auth_Controllers/register_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Routes/routes.dart';

class FirebaseFunctions {
  void signIn(String email, String password) async {
    Get.put(LoginController());
    LoginController controller = Get.find<LoginController>();
    try {
      
    } catch (e) {
      controller.changeErrorStatus(true);
    }
  }

  void signUp(String email, String password) async {
    Get.put(RegisterController());
    RegisterController controller = Get.find<RegisterController>();
    try {

    } catch (e) {
      controller.changeErrorStatus(true);

    }
  }
}
