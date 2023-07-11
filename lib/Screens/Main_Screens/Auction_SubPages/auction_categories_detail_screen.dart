import 'package:barter_x/Components/placeholder_widget.dart';
import 'package:barter_x/Components/top_row.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import '../../../Components/auction_page_components.dart';
import '../../../Controllers/Main_Controllers/Auction_SubPages/auction_category_details_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../../../Utils/Ads/load_ads.dart';
import '../../../Utils/Firebase_Functions/firebase_function.dart';
import '../../../Utils/Widgets/show_modal_sheet.dart';

class AuctionCategoryDetailScreen extends StatefulWidget {
  const AuctionCategoryDetailScreen({super.key});

  @override
  State<AuctionCategoryDetailScreen> createState() =>
      _AuctionCategoryDetailScreenState();
}

class _AuctionCategoryDetailScreenState
    extends State<AuctionCategoryDetailScreen> {
  AuctionCategoryDetailsController controller =
      Get.find<AuctionCategoryDetailsController>();

  @override
  void initState() {
    super.initState();
    loadAd();
    AdClass().loadAd();
    FirebaseFunctions().getFirebaseAuctionDatabyCategory(
        context, controller, Get.arguments[0]);
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
          RefreshIndicator(
            onRefresh: () async {
              try {
                FirebaseFunctions().getFirebaseAuctionDatabyCategory(
                    context, controller, Get.arguments[0]);
                await Future.delayed(const Duration(seconds: 2));
              } on PlatformException catch (e) {
                ReturnWidgets()
                    .returnBottomSheet(context, "An Error Occurred $e");
              }
            },
            child: Stack(
              children: [
                ListView(),
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      TopRow(
                        text: Get.arguments[0],
                      ),
                      Expanded(
                        child: SizedBox(
                          width: size.width,
                          height: size.height * 0.9,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: FutureBuilder(
                              future: controller.data.value,
                              builder: (context,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      data) {
                                if (data.data == null) {
                                  return Center(
                                      child: Lottie.asset(
                                          "assets/jsons/atom-loader.json"));
                                }
                                if (data.hasData && data.data!.docs.isEmpty) {
                                  return PlaceHolderWidget(
                                      size: size,
                                      image: "B10",
                                      mainText:
                                          "Nothing Found in this Category",
                                      buttonText: "Go Back",
                                      buttonFunc: () => Get.back(),
                                      isLoading: false);
                                }
                                return GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 50,
                                            crossAxisSpacing: 20,
                                          mainAxisExtent: 340),
                                  scrollDirection: Axis.vertical,
                                  itemCount: data.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(Routes().productDetails);
                                      },
                                      child: AuctionDataWidgetRow(
                                          size: size,
                                          data: data,
                                          index: (data.data!.docs.length - 1) -
                                              index),
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
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
            ),
          ),
        ],
      )),
    );
  }
}
