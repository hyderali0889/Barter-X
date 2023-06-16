import 'package:barter_x/Components/top_row.dart';
import 'package:barter_x/Models/trade_form_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import '../../../Themes/main_colors.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../../../Utils/Ads/load_ads.dart';

class AuctionBidDetailScreen extends StatefulWidget {
  const AuctionBidDetailScreen({super.key});

  @override
  State<AuctionBidDetailScreen> createState() => _AuctionBidDetailScreenState();
}

class _AuctionBidDetailScreenState extends State<AuctionBidDetailScreen> {

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
                  text: "Bid Details",
                ),
                Expanded(
                    child: Column(
                  children: [
                    SizedBox(
                        width: size.width,
                        height: size.height * 0.86,
                        child: ListView(
                          children: [
                            Padding(
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            Get.arguments[TradeFormModel().img],
                                        placeholder: (context, url) =>
                                            Lottie.asset(
                                                "assets/jsons/atom-loader.json"),
                                      ),
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          Get.arguments[TradeFormModel().title],
                                          style: context.textTheme.bodyLarge!
                                              .copyWith(fontFamily: "bold"),
                                        ),

                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Image.asset(
                                            "assets/icons/img.jpg",
                                            width: 70,
                                            height: 70,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                Get.arguments[
                                                        TradeFormModel().email]
                                                    .split("@")[0]
                                                    .trim(),
                                                style: context
                                                    .textTheme.bodyMedium!
                                                    .copyWith(
                                                        fontFamily: "bold"),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15.0),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Verified Trader",
                                                      style: context
                                                          .textTheme.bodySmall,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Image.asset(
                                                          "assets/icons/Shield.png"),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Description",
                                          style: context.textTheme.bodyMedium!
                                              .copyWith(fontFamily: "bold"),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Text(
                                            Get.arguments[TradeFormModel().des]
                                                .toString()
                                                .trim(),
                                            style: context.textTheme.bodySmall,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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


                               "Error While Loading Ad",
                            style: context.textTheme.bodySmall)))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
