import 'package:barter_x/Screens/Main_Screens/Notification_Screens/notifications.dart';
import 'package:barter_x/Screens/Main_Screens/Notification_Screens/trading_history.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../Components/top_row_no_back.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/notification_controller.dart';
import '../../../Themes/main_colors.dart';
import '../../../Themes/spacing.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../Notification_Screens/wishlist.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  NotificationController controller = Get.find<NotificationController>();
  PageController pageController = PageController(
      initialPage: Get.find<NotificationController>().selectedPill.value);

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
  void initState() {
    super.initState();
    loadAd();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            const TopRowNoBack(
              text: "Notifications",
            ),
            Padding(
              padding: EdgeInsets.only(top: Spacing().sm),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                        color: AppColors().secSoftGrey,
                        borderRadius: BorderRadius.circular(15)),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: InkWell(
                                onTap: () {
                                  controller.changePill(0);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  alignment: Alignment.center,
                                  height: 40,
                                  width: size.width * 0.25,
                                  decoration: BoxDecoration(
                                      color: controller.selectedPill.value == 0
                                          ? AppColors().secRed
                                          : AppColors().secSoftGrey,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Text(
                                    "Alerts",
                                    style: context.textTheme.bodySmall!,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              alignment: Alignment.center,
                              height: 40,
                              width: size.width * 0.25,
                              decoration: BoxDecoration(
                                  color: controller.selectedPill.value == 1
                                      ? AppColors().secRed
                                      : AppColors().secSoftGrey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "Wishlist",
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 20.0),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 100),
                              alignment: Alignment.center,
                              height: 40,
                              width: size.width * 0.25,
                              decoration: BoxDecoration(
                                  color: controller.selectedPill.value == 2
                                      ? AppColors().secRed
                                      : AppColors().secSoftGrey,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "History",
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.73,
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (int page) {
                      controller.changePill(page);
                    },
                    children: const [
                      SubNotificationScreen(),
                      Wishlist(),
                      TradingHistoryScreen(),
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
                        child: Obx(() => Text(!controller.isAdError.value
                            ? " Loading Ad ... "
                            : "Error While Loading Ad")))
              ],
            )),
          ],
        ),
      )),
    );
  }
}
