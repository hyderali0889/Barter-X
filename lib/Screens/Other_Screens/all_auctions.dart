import 'package:barter_x/Themes/main_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';

import '../../Components/placeholder_widget.dart';
import '../../Components/top_row.dart';
import '../../Models/trade_form_model.dart';
import '../../Routes/routes.dart';
import '../../Utils/Firebase_Functions/firebase_function.dart';

class AllAuctionsScreen extends StatefulWidget {
  const AllAuctionsScreen({super.key});

  @override
  State<AllAuctionsScreen> createState() => _AllAuctionsScreenState();
}

class _AllAuctionsScreenState extends State<AllAuctionsScreen> {
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
            const TopRow(
              text: "All Auctions",
            ),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("Auction")
                    .where(TradeFormModel().userId,
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .get(),
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Lottie.asset("assets/jsons/atom-loader.json"),
                    );
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return PlaceHolderWidget(
                        size: size,
                        image: "B3",
                        mainText: "You don't have any Auctions Yet",
                        buttonText: "Start an Auction",
                        buttonFunc: () {
                          Get.toNamed(Routes().addAuctionForm);
                        },
                        isLoading: false);
                  }

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 300,
                        mainAxisExtent: 280,
                        crossAxisSpacing: 50,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        DateTime date = snapshot
                            .data!.docs[index][TradeFormModel().date]
                            .toDate();
                        DateTime date2 = DateTime.now();

                        Duration showingDate = date.difference(
                            DateTime(date2.year, date2.month, date2.day));

                        if (showingDate.inDays < 0) {
                          FirebaseFunctions().markAsinActive(
                              context,
                              snapshot.data!.docs[index]
                                  [TradeFormModel().productId]);
                        }
                        if (showingDate.inDays < -6) {
                          FirebaseFunctions().deleteADocument(
                              context,
                              snapshot.data!.docs[index]
                                  [TradeFormModel().productId],
                              "Auction");
                        }
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes().auctionProductDetails,
                                arguments: snapshot.data!.docs[index]);
                          },
                          child: Container(
                              height: 280,
                              width: 140,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors().secDarkGrey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: CachedNetworkImage(
                                      height: 120,
                                      width: 80,
                                      imageUrl: snapshot.data!.docs[index]
                                          [TradeFormModel().img],
                                      placeholder: (context, url) {
                                        return Lottie.asset(
                                            "assets/jsons/atom-loader.json");
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: Text(snapshot.data!.docs[index]
                                        [TradeFormModel().title] ,
                                      maxLines: 1,

                                        ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Ending In : ",
                                        style: context.textTheme.bodySmall,
                                      ),
                                      Text("${showingDate.inDays} Days",
                                      maxLines: 1,

                                          style: context.textTheme.bodySmall),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                            width: 160,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: AppColors().secRed,
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text("Show All Bids",
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            color: AppColors()
                                                                .primaryWhite)),
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 15.0),
                                                  child: Icon(
                                                    UniconsLine.podium,
                                                    color:
                                                        AppColors().primaryWhite,
                                                  ),
                                                )
                                              ],
                                            ))),
                                  )
                                ],
                              )),
                        );
                      },
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      )),
    );
  }
}
