import 'package:barter_x/Screens/Main_Screens/Notification_Screens/notifications.dart';
import 'package:barter_x/Screens/Main_Screens/Notification_Screens/trading_history.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/bottom_app_bar.dart';
import '../../../Components/top_row_no_back.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/notification_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/main_colors.dart';
import '../../../Themes/spacing.dart';

import 'wallet_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController controller = Get.find<NotificationController>();
  PageController pageController = PageController(
      initialPage: Get.find<NotificationController>().selectedPill.value);

  // @override
  // void initState() {
  //   super.initState();
  //   searchForPoints();
  // }

  // void searchForPoints() async {
  //   dynamic query = await FirebaseFirestore.instance
  //       .collection(FirebaseAuth.instance.currentUser!.uid)
  //       .doc("user_data")
  //       .get();
  //   if (query == null) {
  //     controller.initWallet(query["Points"]);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void closeBottomBar() {
      controller.changeErrorStatus(false);
    }

    void tryAgainBottomBar() {
      controller.changeErrorStatus(false);
    }

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                TopRowNoBack(
                  text: "Notifications",
                  icon: UniconsLine.shopping_cart_alt,
                  firstFunc: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(top: Spacing().sm),
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                            color: AppColors().secSoftGrey,
                            borderRadius: BorderRadius.circular(15)),
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: InkWell(
                                    onTap: () {
                                      controller.changePill(0);
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 100),
                                      alignment: Alignment.center,
                                      height: 40,
                                      width: size.width * 0.40,
                                      decoration: BoxDecoration(
                                          color:
                                              controller.selectedPill.value == 0
                                                  ? AppColors().secRed
                                                  : AppColors().secSoftGrey,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Text(
                                        "Alerts",
                                        style: context.textTheme.bodySmall!,
                                      ),
                                    )),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 20.0),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: size.width * 0.40,
                                  decoration: BoxDecoration(
                                      color: controller.selectedPill.value == 2
                                          ? AppColors().secRed
                                          : AppColors().secSoftGrey,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "History",
                                    style: context.textTheme.bodySmall,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                          width: size.width,
                          height: size.height * 0.7,
                          child: PageView(
                            controller: pageController,
                            onPageChanged: (int page) {
                              controller.changePill(page);
                              // if (page == 1 ) {
                              //   Get.offAllNamed(Routes().registerWallet);
                              // }
                            },
                            children: const [
                              SubNotificationScreen(),
                              TradingHistoryScreen()
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
             errorMsg: controller.errorMsg.value,
              closeFunction: closeBottomBar,
              tryAgainFunction: tryAgainBottomBar,
              buttonWidget: Text(
                "Try Again",
                style: context.textTheme.displayMedium,
              ),
            ),
          )Obx(
            () => BottomBar(
              controller: controller,
              size: size,
              errorTitle: "An Error Occurred",

        ],
      )),
    );
  }
}
