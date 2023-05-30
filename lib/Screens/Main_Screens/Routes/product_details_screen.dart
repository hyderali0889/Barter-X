import 'package:barter_x/Components/top_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../Controllers/Main_Controllers/Route_Controllers/product_details_controller.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../../../Utils/Ads/load_ads.dart';
import '../../../Utils/Widgets/show_modal_sheet.dart';

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
          RefreshIndicator(
            onRefresh: () async {
              try {
                await Future.delayed(const Duration(seconds: 2));
              } on PlatformException catch (e) {
                      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
              }
            },
            child:
               Stack(
                children: [
                  ListView(),
                  SizedBox(
                    width: size.width,
                    height: size.height,
                    child: const Column(
                      children: [
                        TopRow(
                          text: "Product Details",

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
                 ],
      )),
    );
  }
}
