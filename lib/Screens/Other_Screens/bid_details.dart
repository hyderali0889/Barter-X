import 'package:barter_x/Controllers/Main_Controllers/Other_Controllers/auction_bid_details_controller.dart';
import 'package:barter_x/Models/trade_form_model.dart';
import 'package:barter_x/Utils/Firebase_Functions/firebase_function.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Themes/main_colors.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../../../Utils/Ads/load_ads.dart';
import '../../Components/new_product_button.dart';
import '../../Components/top_row.dart';
import '../../Components/top_row_no_back.dart';
import '../../Routes/routes.dart';

class BidDetailScreen extends StatefulWidget {
  const BidDetailScreen({super.key});

  @override
  State<BidDetailScreen> createState() => _BidDetailScreenState();
}

class _BidDetailScreenState extends State<BidDetailScreen> {
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

    AuctionBidDetailsController controller =
        Get.find<AuctionBidDetailsController>();

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Get.arguments[TradeFormModel().userId] ==
                        FirebaseAuth.instance.currentUser!.uid
                    ? const TopRow(
                        text: "Bid Details",
                      )
                    : const TopRowNoBack(
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
                                  Get.arguments[TradeFormModel().userId] !=
                                          FirebaseAuth.instance.currentUser!.uid
                                      ? Obx(
                                          () => controller.isDone.value ||
                                                  Get.arguments[TradeFormModel()
                                                      .isAccepted]
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20.0),
                                                  child: Center(
                                                      child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          SizedBox(
                                                            width: 200,
                                                            child: ProductButton()
                                                                .newProductButton(
                                                                    context
                                                                        .textTheme,
                                                                    size,
                                                                    "Contact Bider",
                                                                    UniconsLine
                                                                        .phone,
                                                                    () {
                                                              Uri par = Uri.parse(
                                                                  "tel:${Get.arguments[TradeFormModel().phone]}");
                                                              launchUrl(par);
                                                            },
                                                                    AppColors()
                                                                        .secGreen),
                                                          ),
                                                          SizedBox(
                                                            width: 200,
                                                            child: ProductButton()
                                                                .newProductButton(
                                                                    context
                                                                        .textTheme,
                                                                    size,
                                                                    "Contact Bider",
                                                                    UniconsLine
                                                                        .mailbox,
                                                                    () {
                                                              final Uri params =
                                                                  Uri(
                                                                scheme:
                                                                    'mailto',
                                                                path: Get
                                                                        .arguments[
                                                                    TradeFormModel()
                                                                        .email],
                                                              );

                                                              launchUrl(params);
                                                            },
                                                                    AppColors()
                                                                        .secRed),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 5.0,
                                                                top: 20),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: ProductButton()
                                                              .newProductButton(
                                                                  context
                                                                      .textTheme,
                                                                  size,
                                                                  "Go Back",
                                                                  UniconsLine
                                                                      .arrow_left,
                                                                  () {
                                                            Get.toNamed(Routes()
                                                                .navigationScreen);
                                                          },
                                                                  AppColors()
                                                                      .secRed),
                                                        ),
                                                      ),
                                                    ],
                                                  )),
                                                )
                                              : Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20.0),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 5.0),
                                                        child: SizedBox(
                                                          width: 200,
                                                          child: ProductButton()
                                                              .newProductButton(
                                                                  context
                                                                      .textTheme,
                                                                  size,
                                                                  "Go Back",
                                                                  UniconsLine
                                                                      .arrow_left,
                                                                  () {
                                                            Get.toNamed(Routes()
                                                                .navigationScreen);
                                                          },
                                                                  AppColors()
                                                                      .secRed),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 200,
                                                        child: ProductButton().newProductButton(
                                                            context.textTheme,
                                                            size,
                                                            controller.isLoading
                                                                    .value
                                                                ? "Loading"
                                                                : "Accept Bid",
                                                            UniconsLine.check,
                                                            () async {
                                                          controller
                                                              .startLoading(
                                                                  true);

                                                          await FirebaseFunctions()
                                                              .acceptBid(
                                                                  context,
                                                                  Get.arguments[
                                                                      TradeFormModel()
                                                                          .title]);
                                                          controller
                                                              .markDone(true);
                                                          controller
                                                              .startLoading(
                                                                  false);
                                                        },
                                                            controller.isLoading
                                                                    .value
                                                                ? AppColors()
                                                                    .secHalfGrey
                                                                : AppColors()
                                                                    .secGreen),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                        )
                                      : Container(),
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
                        child: Obx(() => Text("Error While Loading Ad",
                            style: context.textTheme.bodySmall)))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
