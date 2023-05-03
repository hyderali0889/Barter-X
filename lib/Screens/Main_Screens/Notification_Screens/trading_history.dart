import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/placeholder_widget.dart';
import '../../../Controllers/Main_Controllers/Navigation_Controller/navigation_controller.dart';
import '../../../Routes/routes.dart';

class TradingHistoryScreen extends StatefulWidget {
  const TradingHistoryScreen({super.key});

  @override
  State<TradingHistoryScreen> createState() => _TradingHistoryScreenState();
}

class _TradingHistoryScreenState extends State<TradingHistoryScreen> {
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
            image: "B1",
            mainText: "No History Found. Start Trading!",
            buttonText: "Go Home",
            isLoading: false,
            buttonFunc: () {
                  Get.offAllNamed(Routes().navigationScreen, arguments: 0);

            },
          )),
        ],
      )),
    );
  }
}
