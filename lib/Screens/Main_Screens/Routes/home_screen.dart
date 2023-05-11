import 'package:barter_x/Models/trade_form_model.dart';
import 'package:barter_x/Themes/main_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Components/bottom_app_bar.dart';
import '../../../Components/placeholder_widget.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/home_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/spacing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.find<HomeController>();

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
                Padding(
                  padding: EdgeInsets.only(top: Spacing().sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Padding(
                        padding: const EdgeInsets.only(left: 50.0),
                        child: Text(
                          "Barter X",
                          style: context.textTheme.bodyMedium!.copyWith(
                              color: AppColors().primaryBlue,
                              fontFamily: "bold"),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                                onTap: () {},
                                child: const Icon(UniconsLine.bell)),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  UniconsLine.shopping_cart_alt,
                                )),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FutureBuilder(
                    
                      future:
                          FirebaseFirestore.instance.collection("Trade").get(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              data) {
                        if (!data.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (data.data!.docs.isNotEmpty ) {
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: Spacing().md),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.red,
                                  ),
                                  width: 380,
                                  height: 200,
                                ),
                              ),
                            ],
                          );
                        } else {
                          return PlaceHolderWidget(
                            size: size,
                            image: "A6",
                            mainText:
                                "Barter Screen is where you enlist a product to be traded with a specific object. ",
                            buttonText: "Start a Trade",
                            isLoading: false,
                            buttonFunc: () {
                              Get.toNamed(Routes().addTradeForm);
                            },
                          );
                        }
                      }),
                )
              ],
            ),
          ),
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
