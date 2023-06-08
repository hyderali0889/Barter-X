import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import '../../../Controllers/Main_Controllers/Navigation_Controller/navigation_controller.dart';
import '../../../Themes/main_colors.dart';
import '../Routes/auction_screen.dart';
import '../Routes/e_waste_screen.dart';
import '../Routes/home_screen.dart';
import '../Routes/notification_screen.dart';
import '../Routes/profile_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  NavigationController controller = Get.find<NavigationController>();

  @override
  void initState() {
    super.initState();

    if (Get.arguments != null) {

      controller.changePage(Get.arguments[0]);
      
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> screen = [
      const HomeScreen(),
      const AuctionScreen(),
      const EWasteScreen(),
      const NotificationScreen(),
      const ProfileScreen()
    ];
    return Scaffold(
      body: Obx(() => SafeArea(child: screen[controller.selectedPage.value])),
      bottomNavigationBar: Container(
        height: size.height * 0.06,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: AppColors().primaryBlack, width: 1))),
        child: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                  onTap: () {
                    controller.changePage(0);
                  },
                  child: SizedBox(
                    width: size.width * 0.2,
                    height: size.height * 0.06,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(UniconsLine.home_alt,
                            color: controller.selectedPage.value == 0
                                ? AppColors().secRed
                                : AppColors().secHalfGrey),
                        controller.selectedPage.value == 0
                            ? Text(
                                "Home",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors().secRed,
                                    fontFamily: "bold"),
                              )
                            : Container()
                      ],
                    ),
                  )),
              InkWell(
                  onTap: () {
                    controller.changePage(1);
                  },
                  child: SizedBox(
                    width: size.width * 0.2,
                    height: size.height * 0.06,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(UniconsLine.podium,
                            color: controller.selectedPage.value == 1
                                ? AppColors().secRed
                                : AppColors().secHalfGrey),
                        controller.selectedPage.value == 1
                            ? Text(
                                "Auctions",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors().secRed,
                                    fontFamily: "bold"),
                              )
                            : Container()
                      ],
                    ),
                  )),
              InkWell(
                  onTap: () {
                    controller.changePage(2);
                  },
                  child: SizedBox(
                    width: size.width * 0.2,
                    height: size.height * 0.06,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(UniconsLine.hdd,
                            color: controller.selectedPage.value == 2
                                ? AppColors().secRed
                                : AppColors().secHalfGrey),
                        controller.selectedPage.value == 2
                            ? Text(
                                "E-Wastes",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors().secRed,
                                    fontFamily: "bold"),
                              )
                            : Container()
                      ],
                    ),
                  )),
              InkWell(
                  onTap: () {
                    controller.changePage(3);
                  },
                  child: SizedBox(
                    width: size.width * 0.2,
                    height: size.height * 0.06,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(UniconsLine.clipboard_notes,
                            color: controller.selectedPage.value == 3
                                ? AppColors().secRed
                                : AppColors().secHalfGrey),
                        controller.selectedPage.value == 3
                            ? Text(
                                "Notifications",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors().secRed,
                                    fontFamily: "bold"),
                              )
                            : Container()
                      ],
                    ),
                  )),
              InkWell(
                  onTap: () {
                    controller.changePage(4);
                  },
                  child: SizedBox(
                    width: size.width * 0.2,
                    height: size.height * 0.06,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(UniconsLine.setting,
                            color: controller.selectedPage.value == 4
                                ? AppColors().secRed
                                : AppColors().secHalfGrey),
                        controller.selectedPage.value == 4
                            ? Text(
                                "Profile",
                                style: context.textTheme.bodySmall!.copyWith(
                                    color: AppColors().secRed,
                                    fontFamily: "bold"),
                              )
                            : Container()
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
