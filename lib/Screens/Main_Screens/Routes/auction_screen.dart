import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/bottom_app_bar.dart';
import '../../../Components/placeholder_widget.dart';
import '../../../Components/top_row_no_back.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/auction_controller.dart';


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
                TopRowNoBack(text: "Auctions", icon:UniconsLine.shopping_cart_alt , firstFunc: (){},),

                Expanded(
                  child:PlaceHolderWidget(
                  size: size,
                  image: "A7",
                  mainText: "No Auctions Found in your area.",
                  buttonText: "Start an Auction",
                  isLoading: false,
                  buttonFunc: () {},
                )



                ),
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
