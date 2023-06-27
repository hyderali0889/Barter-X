import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/top_row_no_back.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../Controllers/Main_Controllers/Route_Controllers/profile_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/main_colors.dart';
import '../../../Themes/spacing.dart';
import '../../../Utils/Ads/admob_ids.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController controller = Get.find<ProfileController>();

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

  void getUserPoints() async {

    DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
        .instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (data.exists) {
      controller.setUserPoints(data.data()!["Points"].toString());
    }
  }

  @override
  void initState() {
    super.initState();

    loadAd();
    getUserPoints();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
            Get.toNamed(Routes().addAuctionForm);
          },
          icon: UniconsLine.podium,
          innerText: "Auction",
        ),
        MenuIcons(
          bgColor: AppColors().primaryPurple,
          func: () {
            Get.toNamed(Routes().addEWasteForm);
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
          func: () {
            Get.toNamed(Routes().allTrades);
          },
          icon: UniconsLine.home_alt,
          innerText: "Trade",
        ),
        MenuIcons(
          bgColor: AppColors().primaryYellow,
          func: () {
            Get.toNamed(Routes().allAuctions);
          },
          icon: UniconsLine.podium,
          innerText: "Auction",
        ),
        MenuIcons(
          bgColor: AppColors().secHalfGrey,
          func: () {
            Get.toNamed(Routes().allEWastes);
          },
          icon: UniconsLine.hdd,
          innerText: "E-Waste",
        ),
      ],
    );
    Row otherSettings = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MenuIcons(
          bgColor: AppColors().secRed,
          func: () {
            Get.toNamed(Routes().allBids);
          },
          icon: UniconsLine.bitcoin_alt,
          innerText: "Your Bids",
        ),
        MenuIcons(
          bgColor: AppColors().secHalfGrey,
          func: () {
            Get.toNamed(Routes().changePassword);
          },
          icon: UniconsLine.key_skeleton_alt,
          innerText: "Change Password",
        ),
        MenuIcons(
          bgColor: AppColors().primaryPurple,
          func: () {
            FirebaseAuth.instance.signOut();
            Get.offAllNamed(Routes().splashScreen);
          },
          icon: UniconsLine.exit,
          innerText: "Log Out",
        ),
      ],
    );

    List<String> userName =
        FirebaseAuth.instance.currentUser!.email.toString().split("@");

    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            const TopRowNoBack(
              text: "Profile",
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
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(
                                    width: 150,
                                    height: 150,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage("assets/icons/img.jpg"),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10.0),
                                    child: Text(
                                      "Welcome ${userName[0]}",
                                      style: context.textTheme.bodyMedium!
                                          .copyWith(
                                              color: AppColors().primaryWhite,
                                              fontFamily: "bold"),
                                    ),
                                  )
                                ],
                              ),
                              Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors().labelOffRed,
                                    borderRadius: BorderRadius.circular(15)),
                                width: 150,
                                height: 50,
                                child: Obx(
                                  ()=> Text(
                                    "Points : ${controller.userPoints.value != "0" ? controller.userPoints.value : "Loading"}",
                                    style: context.textTheme.bodyMedium!
                                        .copyWith(fontFamily: "bold"),
                                  ),
                                ),
                              )
                            ],
                          ),
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
                          MainView(
                            title: "Other Settings",
                            row: otherSettings,
                          ),

                          Align(
                            alignment: Alignment.center,
                            child:  Padding(
padding:const EdgeInsets.all(30),
                             child: Text("Your id could get banned if your points are less then -3. Be nice to your customers to get positive points. For more info contact us at hyderali0889@gmail.com" , style: context.textTheme.bodySmall!.copyWith(fontSize: 10),))
                           )
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
                  : Container(
                      alignment: Alignment.center,
                      width: size.width,
                      height: 60,
                      child: Obx(() => Text(!controller.isAdError.value
                          ? " Loading Ad ... "
                          : "Error While Loading Ad")))
            ]))
          ],
        ),
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
