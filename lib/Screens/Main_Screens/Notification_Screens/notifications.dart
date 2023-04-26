import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/placeholder_widget.dart';
import '../../../Controllers/Main_Controllers/Navigation_Controller/navigation_controller.dart';

class SubNotificationScreen extends StatefulWidget {
  const SubNotificationScreen({super.key});

  @override
  State<SubNotificationScreen> createState() => _SubNotificationScreenState();
}

class _SubNotificationScreenState extends State<SubNotificationScreen> {
  NavigationController navController = Get.find<NavigationController>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: PlaceHolderWidget(
            size: size,
            image: "B2",
            mainText: "Hmmm. No Notifications.",
            buttonText: "Go Home",
            isLoading: false,
            buttonFunc: () {
              navController.changePage(0);
            },
          )),
        ],
      )),
    );
  }
}
