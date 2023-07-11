import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../Components/bid_card.dart';
import '../../Components/placeholder_widget.dart';
import '../../Components/top_row.dart';
import '../../Models/trade_form_model.dart';
import '../../Routes/routes.dart';

class AllBidsScreen extends StatefulWidget {
  const AllBidsScreen({super.key});

  @override
  State<AllBidsScreen> createState() => _AllBidsScreenState();
}

class _AllBidsScreenState extends State<AllBidsScreen> {
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
              text: "All Bids",
            ),
            Expanded(
              child: FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("Bids")
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
                        mainText: "You don't haven't bid on any Auction Yet",
                        buttonText: "Start Biding",
                        buttonFunc: () {
                          Get.offAllNamed(Routes().navigationScreen,
                              arguments: [1]);
                        },
                        isLoading: false);
                  }

                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                      gridDelegate:

                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                            crossAxisSpacing: 20,
                                          mainAxisSpacing: 50,
                                          mainAxisExtent: 270),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return BidCard(snapshot: snapshot, index: index);
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
