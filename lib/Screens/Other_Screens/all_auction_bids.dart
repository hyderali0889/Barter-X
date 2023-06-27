import 'package:barter_x/Components/bid_card.dart';
import 'package:barter_x/Components/placeholder_widget.dart';
import 'package:barter_x/Components/top_row.dart';
import 'package:barter_x/Models/trade_form_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllAuctionBids extends StatefulWidget {
  const AllAuctionBids({super.key});

  @override
  State<AllAuctionBids> createState() => _AllAuctionBidsState();
}

class _AllAuctionBidsState extends State<AllAuctionBids> {
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
            const TopRow(text: "All Bids"),
            FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("Bids")
                    .where(TradeFormModel().bidOn, isEqualTo: Get.arguments)
                    .get(),
                builder: ((context, snapshot) {
                  if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
                    return SizedBox(
                      width: size.width,
                      height: size.height * 0.9,
                      child: Center(
                        child: PlaceHolderWidget(
                          buttonFunc: () {
                            Get.back();
                          },
                          buttonText: "Go Back",
                          image: "B2",
                          isLoading: false,
                          mainText: "No Bids Found for your product",
                          size: size,
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return SizedBox(
                      width: size.width,
                      height: size.height * 0.9,
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return SizedBox(
                    width: size.width,
                    height: size.height * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: GridView.builder(
                            gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 50,
                              mainAxisExtent: 270),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return BidCard(snapshot: snapshot, index: index);
                          }),
                    ),
                  );
                }))
          ],
        ),
      )),
    );
  }
}
