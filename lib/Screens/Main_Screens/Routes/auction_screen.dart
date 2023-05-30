import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/placeholder_widget.dart';
import '../../../Components/top_row_no_back.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/auction_controller.dart';
import '../../../Routes/routes.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key});

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
  AuctionController controller = Get.find<AuctionController>();

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
                const TopRowNoBack(
                  text: "Auctions",

                ),
                Expanded(
                    child: PlaceHolderWidget(
                  size: size,
                  image: "A7",
                  mainText:
                      "Auction Screen is where you enlist a product and wait for others to bid on your product.",
                  buttonText: "Start an Auction",
                  isLoading: false,
                  buttonFunc: () {
                    Get.toNamed(Routes().addAuctionForm);
                  },
                )),
              ],
            ),
          )),
    );
  }
}
