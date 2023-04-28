import 'package:barter_x/Themes/main_colors.dart';
import 'package:barter_x/Themes/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/bottom_app_bar.dart';
import '../../../Components/top_row_no_back.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/wallet_controller.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  WalletController controller = Get.find<WalletController>();

   void closeBottomBar() {
      controller.changeErrorStatus(false);
    }

    void tryAgainBottomBar() {
      controller.changeErrorStatus(false);
    }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TopRowNoBack(
                        text: "Wallet",
                        icon: UniconsLine.shopping_cart_alt,
                        firstFunc: () {},
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          left: Spacing().sm,
                          right: Spacing().sm,
                          top: Spacing().sm,
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          width: size.width * 0.8,
                          height: 200,
                          decoration: BoxDecoration(
                              color: AppColors().labelOffBlue,
                              borderRadius: BorderRadius.circular(50)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "0 Points",
                              style: context.textTheme.bodyLarge!
                                  .copyWith(fontSize: 30),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          "* Your Barter Points Determine the amount of trust you've gained while trading with Barter X. \n\n Negative point indicates Scammer and will can ever block your account.",
                          style:
                              context.textTheme.bodyLarge!.copyWith(fontSize: 18),
                        ),
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
          )),
    );
  }
}
