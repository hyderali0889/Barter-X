// ignore_for_file: use_build_context_synchronously

import 'package:barter_x/Components/main_button.dart';
import 'package:barter_x/Controllers/Main_Controllers/Trade_and_EWaste_SubPages/confimation_controller.dart';
import 'package:barter_x/Models/trade_form_model.dart';
import 'package:barter_x/Themes/main_colors.dart';
import 'package:barter_x/Utils/Firebase_Functions/firebase_function.dart';
import 'package:barter_x/Utils/Widgets/show_modal_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Components/new_product_button.dart';
import '../../Models/history.dart';
import '../../Routes/routes.dart';
import '../../main.dart';
import '../../objectbox.g.dart';

class ConfirmationScreen extends StatefulWidget {
  const ConfirmationScreen({super.key});

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
  Box<HistoryModel> historyModel = objectBox.store.box<HistoryModel>();
  ConfirmationController controller = Get.find<ConfirmationController>();

  @override
  void initState() {
    super.initState();
    getActiveTradeData();
  }

  getActiveTradeData() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFunctions()
          .getActiveTrades(context, FirebaseAuth.instance.currentUser!.uid);

      await FirebaseFunctions().getSingleProduct(
          context,
          data.data()!["ActiveTradeCat"],
          data.data()!["ActiveTradeId"],
          controller);
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "$e");
    }
  }

  deleteData() async {
    DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFunctions()
        .getActiveTrades(context, FirebaseAuth.instance.currentUser!.uid);

    await FirebaseFunctions().deleteADocument(
        context, data.data()!["ActiveTradeId"], data.data()!["ActiveTradeCat"]);

    await FirebaseFunctions()
        .removeActiveTrade(context, FirebaseAuth.instance.currentUser!.uid);
  }

  goHome() async {
    await FirebaseFunctions()
        .removeActiveTrade(context, FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                  width: size.width,
                  height: 50,
                  child: Center(
                    child: Text("Active Trade",
                        style: context.textTheme.bodyLarge),
                  )),
            ),
            Obx(
              () => Expanded(
                  child: controller.data.value == null
                      ? Center(
                          child: Lottie.asset("assets/jsons/atom-loader.json"))
                      : Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Text(
                                controller.data.value!.docs[0]
                                    [TradeFormModel().title],
                                style: context.textTheme.bodyLarge,
                              ),
                              const Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Row(
                                  children: [
                                    Text(
                                      "Trading With : ",
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(fontFamily: "bold"),
                                    ),
                                    Text(
                                      controller.data.value!.docs[0]
                                          [TradeFormModel().tradeWith],
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Description : ",
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(fontFamily: "bold"),
                                    ),
                                    Text(
                                      controller.data.value!.docs[0]
                                          [TradeFormModel().des],
                                      style: context.textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(),
                              MainButton(
                                  size: size,
                                  buttonText: "Send a Mail",
                                  actionFunction: () {
                                    try {
                                      final Uri params = Uri(
                                        scheme: 'mailto',
                                        path: controller.data.value!.docs[0]
                                            [TradeFormModel().email],
                                      );

                                      launchUrl(params);
                                    } catch (e) {
                                      ReturnWidgets()
                                          .returnBottomSheet(context, "$e");
                                    }
                                  },
                                  mainController: false),
                              MainButton(
                                  size: size,
                                  buttonText: "Contact via Phone",
                                  actionFunction: () {
                                    try {
                                      Uri par = Uri.parse(
                                          "tel:${controller.data.value!.docs[0][TradeFormModel().phone]}");
                                      launchUrl(par);
                                    } catch (e) {
                                      ReturnWidgets()
                                          .returnBottomSheet(context, "$e");
                                    }
                                  },
                                  mainController: false),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Obx(
                                        () => ProductButton().newProductButton(
                                            context.textTheme,
                                            size,
                                            controller.isLoading1.value
                                                ? "Loading"
                                                : "Trade Declined",
                                            UniconsLine.times, () async {
                                          controller.startLoading1(true);
                                          await goHome();
                                          controller.startLoading1(false);

                                          Get.offAllNamed(
                                              Routes().navigationScreen);
                                        },
                                            controller.isLoading1.value
                                                ? AppColors().secHalfGrey
                                                : AppColors().secRed),
                                      ),
                                      Obx(
                                        () => ProductButton().newProductButton(
                                            context.textTheme,
                                            size,
                                            controller.isLoading.value
                                                ? "Loading"
                                                : "Trade Accepted",
                                            UniconsLine.swatchbook, () async {
                                          controller.startLoading(true);
                                          HistoryModel model = HistoryModel(
                                              title:
                                                  controller.data.value!.docs[0]
                                                      [TradeFormModel().title]);
                                          historyModel.put(model);

                                          await deleteData();
                                          controller.startLoading(false);

                                          Get.offAllNamed(
                                              Routes().ratingsScreen,
                                              arguments: controller
                                                      .data.value!.docs[0]
                                                  [TradeFormModel().userId]);
                                        },
                                            controller.isLoading.value
                                                ? AppColors().secHalfGrey
                                                : AppColors().secGreen),
                                      ),
                                    ]),
                              )
                            ],
                          ),
                        )),
            )
          ],
        ),
      )),
    );
  }
}
