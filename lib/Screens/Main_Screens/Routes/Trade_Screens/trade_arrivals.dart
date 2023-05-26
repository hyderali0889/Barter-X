import 'package:barter_x/Utils/load_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../../Components/top_row.dart';
import '../../../../Components/trade_page_components.dart';

class TradeArrivals extends StatefulWidget {
  const TradeArrivals({super.key});

  @override
  State<TradeArrivals> createState() => _TradeArrivalsState();
}

class _TradeArrivalsState extends State<TradeArrivals> {
  @override
  void initState() {
    super.initState();
    AdClass().loadAd();
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
            TopRow(
              text: "New Arrivals",
              icon: UniconsLine.shopping_cart_alt,
              firstFunc: () {},
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 50,
                      mainAxisExtent: 340),
                  scrollDirection: Axis.vertical,
                  itemCount: Get.arguments.data!.docs.length - 1,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: DataWidgetRow(
                          size: size,
                          data: Get.arguments,
                          index: (Get.arguments.data!.docs.length - 1) - index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
