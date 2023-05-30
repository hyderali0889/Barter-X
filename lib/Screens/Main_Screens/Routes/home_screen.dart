import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:unicons/unicons.dart';
import 'package:barter_x/Themes/main_colors.dart';
import '../../../Components/trade_page_components.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/home_controller.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../../../Utils/Firebase_Functions/firebase_function.dart';
import '../../../Utils/Widgets/show_modal_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.find<HomeController>();
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
      FirebaseFunctions().getFirebaseTradeData(controller);
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            RefreshIndicator(
              onRefresh: () async {
                try {
                  controller.refreshData(true);
                  FirebaseFunctions().getFirebaseTradeData(controller);
                  await Future.delayed(const Duration(seconds: 2));
                  controller.refreshData(false);
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
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.08,
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 50.0),
                                  child: Text(
                                    "Barter X",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: AppColors().primaryBlue,
                                            fontFamily: "bold"),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: InkWell(
                                          onTap: () {},
                                          child:
                                              const Icon(UniconsLine.bell)),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 20.0),
                                      child: InkWell(
                                          onTap: () {},
                                          child: const Icon(
                                            UniconsLine.shopping_cart_alt,
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(children: [
                              SizedBox(
                                width: size.width,
                                height: size.height * 0.77,
                                child: ListView(children: [
                                  FutureWidget(
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
                                          width: _bannerAd!.size.width
                                              .toDouble(),
                                          height: _bannerAd!.size.height
                                              .toDouble(),
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
                                          style:
                                              context.textTheme.bodySmall)))
                            ]),
                          )
                        ],
                      ),
                    ),
                  ],
                ),

            ),

          ],
        ),
      ),
    );
  }
}

/*
███╗   ███╗ █████╗ ██╗███╗   ██╗    ██╗   ██╗██╗███████╗██╗    ██╗
████╗ ████║██╔══██╗██║████╗  ██║    ██║   ██║██║██╔════╝██║    ██║
██╔████╔██║███████║██║██╔██╗ ██║    ██║   ██║██║█████╗  ██║ █╗ ██║
██║╚██╔╝██║██╔══██║██║██║╚██╗██║    ╚██╗ ██╔╝██║██╔══╝  ██║███╗██║
██║ ╚═╝ ██║██║  ██║██║██║ ╚████║     ╚████╔╝ ██║███████╗╚███╔███╔╝
╚═╝     ╚═╝╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝      ╚═══╝  ╚═╝╚══════╝ ╚══╝╚══╝

*/
