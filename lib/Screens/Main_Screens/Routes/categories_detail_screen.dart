import 'package:barter_x/Components/top_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/bottom_app_bar.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/category_details_controller.dart';
import '../../../Utils/admob_ids.dart';
import '../../../Utils/load_ads.dart';

class CategoryDetailScreen extends StatefulWidget {
  const CategoryDetailScreen({super.key});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  CategoryDetailsController controller = Get.find<CategoryDetailsController>();

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
    void closeBottomBar() {
      controller.changeErrorStatus(false);
    }

    void tryAgainBottomBar() {
      controller.changeErrorStatus(false);
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              try {
                controller.changeErrorStatus(false);
                await Future.delayed(const Duration(seconds: 2));
              } on PlatformException catch (e) {
                controller.changeErrorMessage(e.message.toString());
                controller.changeErrorStatus(true);
              }
            },
            child: Obx(
              () => Opacity(
                opacity: controller.errorOcurred.value ? 0.6 : 1,
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
                            icon: UniconsLine.shopping_cart_alt,
                            firstFunc: () {},
                          ),
                        ],
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
