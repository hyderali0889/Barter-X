import 'package:barter_x/Components/top_row.dart';
import 'package:barter_x/Models/trade_form_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';

import '../../../Controllers/Main_Controllers/Trade_and_EWaste_SubPages/product_details_controller.dart';
import '../../../Themes/main_colors.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../../../Utils/Ads/load_ads.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  ProductDetailsController controller = Get.find<ProductDetailsController>();

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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 40.0, left: 20, right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Container(
                                  width: size.width * 0.9,
                                  height: size.height * 0.3,
                                  decoration: BoxDecoration(
                                      color: AppColors().secDarkGrey,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        Get.arguments[TradeFormModel().img],
                                    placeholder: (context, url) => Lottie.asset(
                                        "assets/jsons/atom-loader.json"),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Column(
                                  children: [
                                    Text(

                                      Get.arguments[TradeFormModel().title],
                                      style: context.textTheme.bodyLarge!
                                          .copyWith(fontFamily: "bold"),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ))
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
