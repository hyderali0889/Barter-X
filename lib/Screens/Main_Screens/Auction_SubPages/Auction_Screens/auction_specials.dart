import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Components/auction_page_components.dart';
import '../../../../Components/top_row.dart';
import '../../../../Routes/routes.dart';
import '../../../../Utils/Ads/load_ads.dart';
import '../../../../Utils/Generators/random_number_generator.dart';

class AuctionSpecials extends StatefulWidget {
  const AuctionSpecials({super.key});

  @override
  State<AuctionSpecials> createState() => _AuctionSpecialsState();
}

class _AuctionSpecialsState extends State<AuctionSpecials> {
  @override
  void initState() {
    super.initState();
    AdClass().loadAd();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Set<int> randomNumbers = generateRandomNumbers(
        Get.arguments.data!.docs.length ,
        0,
        Get.arguments.data!.docs.length - 1);
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            const TopRow(
              text: "Specials",
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                        crossAxisSpacing: 20,
                      mainAxisSpacing: 50,
                      mainAxisExtent: 340),
                  scrollDirection: Axis.vertical,
                  itemCount: Get.arguments.data!.docs.length ,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Get.toNamed(Routes().productDetails);
                      },
                      child: AuctionDataWidgetRow(
                          size: size,
                          data: Get.arguments,
                          index: randomNumbers.elementAt(index)),
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
