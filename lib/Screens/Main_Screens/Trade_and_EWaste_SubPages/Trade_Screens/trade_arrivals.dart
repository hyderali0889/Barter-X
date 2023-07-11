import 'package:barter_x/Utils/Ads/load_ads.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Components/top_row.dart';
import '../../../../Components/trade_page_components.dart';
import '../../../../Routes/routes.dart';

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
            const TopRow(
              text: "New Arrivals",
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
                        crossAxisSpacing: 20,
                      mainAxisExtent: 340),
                  scrollDirection: Axis.vertical,
                  itemCount: Get.arguments.data!.docs.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes().productDetails);
                      },
                      child: DataWidgetRow(
                          size: size,
                          data: Get.arguments,
                          index: Get.arguments.data!.docs.length > 5
                              ? (Get.arguments.data!.docs.length - 1) - index
                              : index),
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
