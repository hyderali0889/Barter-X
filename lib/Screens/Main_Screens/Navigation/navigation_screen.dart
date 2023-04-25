import 'package:barter_x/Screens/Main_Screens/auction_screen.dart';
import 'package:barter_x/Screens/Main_Screens/e_waste_screen.dart';
import 'package:barter_x/Screens/Main_Screens/home_screen.dart';
import 'package:barter_x/Screens/Main_Screens/notification_screen.dart';
import 'package:barter_x/Screens/Main_Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import '../../../Controllers/Main_Controllers/Navigation_Controller/navigation_controller.dart';
import '../../../Themes/main_colors.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  NavigationController controller = Get.find<NavigationController>();
  
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
                  child: Icon(UniconsLine.home_alt,
                      color: controller.selectedPage.value == 0
                          ? AppColors().secRed
                          : AppColors().secHalfGrey)),
              InkWell(
                  onTap: () {
                    controller.changePage(1);
                  },
                  child: Icon(UniconsLine.hourglass,
                      color: controller.selectedPage.value == 1
                          ? AppColors().secRed
                          : AppColors().secHalfGrey)),
              InkWell(
                  onTap: () {
                    controller.changePage(2);
                  },
                  child: Icon(UniconsLine.battery_empty,
                      color: controller.selectedPage.value == 2
                          ? AppColors().secRed
                          : AppColors().secHalfGrey)),
              InkWell(
                  onTap: () {
                    controller.changePage(3);
                  },
                  child: Icon(UniconsLine.clipboard_notes,
                      color: controller.selectedPage.value == 3
                          ? AppColors().secRed
                          : AppColors().secHalfGrey)),
              InkWell(
                  onTap: () {
                    controller.changePage(4);
                  },
                  child: Icon(UniconsLine.setting,
                      color: controller.selectedPage.value == 4
                          ? AppColors().secRed
                          : AppColors().secHalfGrey)),
            ],
          ),
        ),
      ),
    );
  }
}
