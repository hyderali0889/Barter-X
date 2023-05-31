import 'package:barter_x/Components/top_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../Controllers/Main_Controllers/Route_Controllers/category_details_controller.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../../../Utils/Ads/load_ads.dart';
import '../../../Utils/Widgets/show_modal_sheet.dart';

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
                    child: Column(
                      children: [
                        TopRow(
                          text: Get.arguments[0],

                        ),

                         Expanded(child: Column(
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
              ),

          ),

        ],
      )),
    );
  }
}
