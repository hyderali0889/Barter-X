import 'package:barter_x/Models/trade_form_model.dart';
import 'package:barter_x/Utils/Firebase_Functions/firebase_function.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../Components/placeholder_widget.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/notification_controller.dart';
import '../../../Models/wishlist.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/main_colors.dart';
import '../../../main.dart';
import '../../../objectbox.g.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key});

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {
  NotificationController navController = Get.find<NotificationController>();
  Box<WishlistModel> wishlist = objectBox.store.box<WishlistModel>();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    navController.resetData();
    for (var item in wishlist.getAll()) {
      await FirebaseFunctions().getWishlistProducts(
          context, navController, item.productCategory, item.productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Expanded(
                child: navController.data.isNotEmpty
                    ? Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 15, right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Container(),
                                InkWell(
                                  onTap: () {
                                    wishlist.removeAll();
                                    navController.resetData();
                                  },
                                  child: Text(
                                    "Clear Wishlist",
                                    style: context.textTheme.bodySmall,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.68,
                            child: GridView.builder(
                                itemCount: navController.data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 50,
                                        mainAxisExtent: 340),
                                itemBuilder: (context, index) {
                                  if (navController.data.isEmpty) {
                                    return Center(
                                      child: Lottie.asset(
                                          "assets/jsons/atom-loader.json"),
                                    );
                                  }

                                  if (navController.data[index].docs.isEmpty) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        AppColors().secSoftGrey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(20.0),
                                                  child: Text(
                                                      "This Item has been traded or Deleted by the trader."),
                                                )),
                                          ),
                                        ),
                                      ],
                                    );
                                  }

                                  if (navController.data[index].docs[0]
                                          [TradeFormModel().cat] ==
                                      "Auction") {
                                    return AuctionWidget(
                                        index: index,
                                        navController: navController,
                                        size: size);
                                  }

                                  return TradeWidget(
                                    navController: navController,
                                    size: size,
                                    index: index,
                                  );
                                }),
                          ),
                        ],
                      )
                    : PlaceHolderWidget(
                        size: size,
                        image: "B3",
                        mainText: "Nothing in your Wishlist.",
                        buttonText: "Go Home",
                        isLoading: false,
                        buttonFunc: () {
                          Get.offAllNamed(Routes().navigationScreen,
                              arguments: [0]);
                        },
                      )),
          ),
        ],
      )),
    );
  }
}

class TradeWidget extends StatelessWidget {
  const TradeWidget({
    super.key,
    required this.navController,
    required this.size,
    required this.index,
  });

  final NotificationController navController;
  final Size size;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15, top: 30),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes().productDetails,
              arguments: navController.data[index].docs[0]);
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors().secSoftGrey,
              borderRadius: BorderRadius.circular(10)),
          width: size.width * 0.38,
          height: size.height * 0.4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        placeholder: ((context, url) {
                          return Lottie.asset("assets/jsons/atom-loader.json");
                        }),
                        imageUrl: navController.data[index].docs[0]
                            [TradeFormModel().img],
                        width: size.width * 0.35,
                        height: 140,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    width: size.width * 0.38,
                    height: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Text(
                        navController.data[index].docs[0]
                            [TradeFormModel().title],
                        overflow: TextOverflow.fade,
                        style: context.textTheme.bodySmall!
                            .copyWith(fontFamily: "bold")),
                  ),
                ),
                Container(
                  width: size.width * 0.38,
                  height: 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Trading With :",
                          overflow: TextOverflow.fade,
                          style: context.textTheme.bodySmall),
                      Text(
                          navController.data[index].docs[0]
                              [TradeFormModel().tradeWith],
                          style: context.textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuctionWidget extends StatelessWidget {
  const AuctionWidget({
    super.key,
    required this.size,
    required this.index,
    required this.navController,
  });

  final Size size;
  final int index;
  final NotificationController navController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes().auctionProductDetails,
              arguments: navController.data[index].docs[0]);
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors().secSoftGrey,
              borderRadius: BorderRadius.circular(10)),
          width: size.width * 0.38,
          height: size.height * 0.4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        placeholder: ((context, url) {
                          return Lottie.asset("assets/jsons/atom-loader.json");
                        }),
                        imageUrl: navController.data[index].docs[0]
                            [TradeFormModel().img],
                        width: size.width * 0.35,
                        height: 140,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    width: size.width * 0.38,
                    height: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Text(
                        navController.data[index].docs[0]
                            [TradeFormModel().title],
                        overflow: TextOverflow.fade,
                        style: context.textTheme.bodySmall!
                            .copyWith(fontFamily: "bold")),
                  ),
                ),
                Container(
                  width: size.width * 0.38,
                  height: 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Trading With :",
                          overflow: TextOverflow.fade,
                          style: context.textTheme.bodySmall),
                      Text(
                          navController
                              .data[index].docs[0][TradeFormModel().date]
                              .toString(),
                          style: context.textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
