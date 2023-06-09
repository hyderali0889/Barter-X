import 'package:barter_x/Components/ewaste_page_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../../Components/top_row_no_back.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/ewaste_controller.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../../../Utils/Firebase_Functions/firebase_function.dart';
import '../../../Utils/Widgets/show_modal_sheet.dart';

class EWasteScreen extends StatefulWidget {
  const EWasteScreen({super.key});

  @override
  State<EWasteScreen> createState() => _EWasteScreenState();
}

class _EWasteScreenState extends State<EWasteScreen> {
  EWasteController controller = Get.find<EWasteController>();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getFirestoreData();
    loadAd();
  }

  void getFirestoreData() async {
    try {
      controller.refreshData(true);
      FirebaseFunctions().getFirebaseEWasteData(context, controller);
      await Future.delayed(const Duration(seconds: 2));
      controller.refreshData(false);
    } on PlatformException catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  BannerAd? _bannerAd;

  void loadAd() {
    controller.changeAdError(false);

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
          child: RefreshIndicator(
        onRefresh: () async {
          try {
            controller.refreshData(true);
            FirebaseFunctions().getFirebaseEWasteData(context, controller);
            await Future.delayed(const Duration(seconds: 2));
            controller.refreshData(false);
          } on PlatformException catch (e) {
            ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
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
                  const TopRowNoBack(
                    text: "E-Wastes",
                  ),
                  Expanded(
                    child: Column(children: [
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.8,
                        child: ListView(children: [
                          EWasteFutureWidget(
                            controller: controller,
                            size: size,
                            searchController: searchController,
                          ),
                        ]),
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
                              alignment: Alignment.bottomCenter,
                              width: size.width,
                              height: 60,
                              child: Obx(() => Text(
                                  !controller.isAdError.value
                                      ? " Loading Ad ... "
                                      : "Error While Loading Ad",
                                  style: context.textTheme.bodySmall)))
                    ]),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
