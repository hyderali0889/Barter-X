import 'package:barter_x/Models/alerts.dart';
import 'package:barter_x/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/placeholder_widget.dart';
import '../../../Controllers/Main_Controllers/Navigation_Controller/navigation_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/main_colors.dart';
import '../../../objectbox.g.dart';

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
    Box<AlertModel> model = objectBox.store.box<AlertModel>();
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: model.count() > 0
                  ? Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 15.0, right: 15.0, top: 20),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Container(),
                                InkWell(
                                  onTap: () {
                                    model.removeAll();
                                    setState(() {});
                                  },
                                  child: Text(
                                    "Clear Notifications",
                                    style: context.textTheme.bodySmall,
                                  ),
                                )
                              ]),
                        ),
                        SizedBox(
                          height: size.height * 0.68,
                          child: ListView.builder(
                              itemCount: model.count() +1 ,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Container();
                                }
                                return Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Container(
                                      alignment: Alignment.center,
                                      height: 150,
                                      width: size.width * 0.8,
                                      decoration: BoxDecoration(
                                          color: AppColors().secDarkGrey,
                                          borderRadius:
                                              BorderRadius.circular(14)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                            model.get(index)!.notification),
                                      )),
                                );
                              }),
                        ),
                      ],
                    )
                  : PlaceHolderWidget(
                      size: size,
                      image: "B2",
                      mainText: "Hmmm. No Notifications.",
                      buttonText: "Go Home",
                      isLoading: false,
                      buttonFunc: () {
                        Get.offAllNamed(Routes().navigationScreen,
                            arguments: [0]);
                      },
                    )),
        ],
      )),
    );
  }
}
