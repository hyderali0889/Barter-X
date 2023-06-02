import 'package:barter_x/Components/top_row.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../Controllers/Main_Controllers/Auction_SubPages/auction_product_details_controller.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../../../Utils/Ads/load_ads.dart';

class AuctionProductDetailScreen extends StatefulWidget {
  const AuctionProductDetailScreen({super.key});

  @override
  State<AuctionProductDetailScreen> createState() =>
      _AuctionProductDetailScreenState();
}

class _AuctionProductDetailScreenState
    extends State<AuctionProductDetailScreen> {
  AuctionProductDetailsController controller =
      Get.find<AuctionProductDetailsController>();

  @override
  void initState() {
    super.initState();
    loadAd();
    AdClass().loadAd();
  }

  BannerAd? _bannerAd;

  void loadAd() {
    _bannerAd = BannerAd(
      adUnitId: AdmobIds().bannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, err) {
          controller.changeAdError(true);
          ad.dispose();
        },
      ),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                const TopRow(
                  text: "Product Details",
                ),
                Expanded(
                    child: Column(
                  children: [
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.8,
                    )
                  ],
                )),
                _bannerAd != null
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: SafeArea(
                          child: SizedBox(
                            width: _bannerAd!.size.width.toDouble(),
                            height: _bannerAd!.size.height.toDouble(),
                            child: AdWidget(ad: _bannerAd!),
                          ),
                        ),
                      )
                    : Container(
                        alignment: Alignment.center,
                        width: size.width,
                        height: 60,
                        child: Obx(() => Text(
                            !controller.isAdError.value
                                ? " Loading Ad ... "
                                : "Error While Loading Ad",
                            style: context.textTheme.bodySmall)))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
