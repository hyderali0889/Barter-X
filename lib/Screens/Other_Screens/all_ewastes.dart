import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Components/placeholder_widget.dart';
import '../../Components/top_row.dart';
import '../../Models/trade_form_model.dart';
import '../../Routes/routes.dart';
import '../../Themes/main_colors.dart';

class AllEWasteScreen extends StatefulWidget {
  const AllEWasteScreen({super.key});

  @override
  State<AllEWasteScreen> createState() => _AllEWasteScreenState();
}

class _AllEWasteScreenState extends State<AllEWasteScreen> {
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
              text: "All EWastes",
            ),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("EWaste")
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
                        mainText: "You don't have any EWastes Yet",
                        buttonText: "Add a Product",
                        buttonFunc: () {
                          Get.toNamed(Routes().addEWasteForm);
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
                        mainAxisExtent: 240,
                        crossAxisSpacing: 50,
                      ),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed(Routes().productDetails,
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
                                    child: Text(
                                      snapshot.data!.docs[index]
                                          [TradeFormModel().title],
                                      maxLines: 1,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Trading With : ",
                                        style: context.textTheme.bodySmall,
                                      ),
                                      Text(
                                          snapshot.data!.docs[index]
                                              [TradeFormModel().tradeWith],
                                          maxLines: 1,
                                          style: context.textTheme.bodySmall),
                                    ],
                                  ),
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
