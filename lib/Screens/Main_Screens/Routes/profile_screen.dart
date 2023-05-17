import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/bottom_app_bar.dart';
import '../../../Components/top_row_no_back.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../Controllers/Main_Controllers/Route_Controllers/profile_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/main_colors.dart';
import '../../../Themes/spacing.dart';
import '../../../Utils/admob_ids.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController controller = Get.find<ProfileController>();

  BannerAd? _bannerAd;

  void loadAd() {
    controller.changeErrorStatus(false);

    _bannerAd = BannerAd(
      adUnitId: AdmobIds().bannerId,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {},
        onAdFailedToLoad: (ad, err) {
          controller.changeErrorMessage('Cannot Load Ads ${err.message}');
          controller.changeErrorStatus(true);
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
    void closeBottomBar() {
      controller.changeErrorStatus(false);
    }

    void tryAgainBottomBar() {
      controller.changeErrorStatus(false);
    }

    Row addNewRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MenuIcons(
          bgColor: AppColors().secGreen,
          func: () {
            Get.toNamed(Routes().addTradeForm);
          },
          icon: UniconsLine.home_alt,
          innerText: "Trade",
        ),
        MenuIcons(
          bgColor: AppColors().secRed,
          func: () {
            Get.toNamed(Routes().addTradeForm, arguments: "a");
          },
          icon: UniconsLine.podium,
          innerText: "Auction",
        ),
        MenuIcons(
          bgColor: AppColors().primaryPurple,
          func: () {
            Get.toNamed(Routes().addTradeForm, arguments: "e");
          },
          icon: UniconsLine.hdd,
          innerText: "E-Waste",
        ),
      ],
    );
    Row seeAllRows = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MenuIcons(
          bgColor: AppColors().secSoftGrey,
          func: () {},
          icon: UniconsLine.home_alt,
          innerText: "Trade",
        ),
        MenuIcons(
          bgColor: AppColors().primaryYellow,
          func: () {},
          icon: UniconsLine.podium,
          innerText: "Auction",
        ),
        MenuIcons(
          bgColor: AppColors().secHalfGrey,
          func: () {},
          icon: UniconsLine.hdd,
          innerText: "E-Waste",
        ),
      ],
    );

    String userName = FirebaseAuth.instance.currentUser!.email
        .toString()
        .replaceAll("@gmail.com", "");

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                TopRowNoBack(
                  text: "Profile",
                  icon: UniconsLine.shopping_cart_alt,
                  firstFunc: () {},
                ),
                Expanded(
                    child: Column(children: [
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.8,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: Spacing().xs),
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width,
                            height: size.height * 0.275,
                            color: AppColors().primaryPurple,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  height: 175,
                                  width: 175,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors().secHalfGrey),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Welcome $userName",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(
                                            color: AppColors().primaryWhite,
                                            fontFamily: "bold"),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: ListView(
                            children: [
                              MainView(
                                title: "Add a New",
                                row: addNewRow,
                              ),
                              MainView(
                                title: "See All of Your",
                                row: seeAllRows,
                              ),
                            ],
                          ),
                        )
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
                      : Container()
                ]))
              ],
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

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required this.row,
    required this.title,
  });
  final String title;
  final Row row;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: Spacing().sm),
                child: Text(
                  title,
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontFamily: "bold"),
                ),
              ),
              row
            ]));
  }
}

class MenuIcons extends StatelessWidget {
  const MenuIcons({
    super.key,
    required this.func,
    required this.bgColor,
    required this.icon,
    required this.innerText,
  });

  final VoidCallback func;
  final Color bgColor;
  final IconData icon;
  final String innerText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Spacing().xs, left: Spacing().sm),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: func,
              child: Container(
                width: 65,
                height: 65,
                decoration: BoxDecoration(
                    color: bgColor, borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  icon,
                  size: 30,
                  color: AppColors().labelOffBlack,
                ),
              ),
            ),
          ),
          Text(
            innerText,
            style: context.textTheme.bodySmall,
          )
        ],
      ),
    );
  }
}
