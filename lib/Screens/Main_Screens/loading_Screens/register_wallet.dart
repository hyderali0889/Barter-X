import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../Components/bottom_app_bar.dart';
import '../../../Controllers/Main_Controllers/loading_Controllers/register_wallet_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../Routes/routes.dart';

class RegisterWallet extends StatefulWidget {
  const RegisterWallet({super.key});

  @override
  State<RegisterWallet> createState() => _RegisterWalletState();
}

class _RegisterWalletState extends State<RegisterWallet> {
  RegisterWalletController controller = Get.find<RegisterWalletController>();
  @override
  void initState() {
    super.initState();
    initUserWallet();
  }

  void initUserWallet() async {
    try {
      controller.changeErrorStatus(false);
      await FirebaseFirestore.instance
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc("user_data")
          .set({"points": 0});

      Get.offAllNamed(Routes().navigationScreen);
    } catch (e) {
      controller.changeErrorStatus(true);

     }
  }

  @override
  Widget build(BuildContext context) {
    void closeBottomBar() {
      controller.changeErrorStatus(false);
    }

    void tryAgainBottomBar() {
      controller.changeErrorStatus(false);
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset('assets/jsons/atom-loader.json',
                        width: 200, height: 200),
                    Text(
                      "Please wait while we register your Wallet.",
                      style: context.textTheme.bodySmall,
                    )
                  ],
                )),
            Obx(
              () => BottomBar(
                controller: controller,
                size: size,
                errorTitle: "An Error Occurred",
                errorMsg: controller.errorMsg.value,
                closeFunction: closeBottomBar,
                tryAgainFunction: tryAgainBottomBar,
                buttonWidget: Text(
                  "Try Again",
                  style: context.textTheme.displayMedium,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
