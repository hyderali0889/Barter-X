import 'package:barter_x/Components/top_row.dart';
import 'package:barter_x/Models/trade_form_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';
import '../../../Components/new_product_button.dart';
import '../../../Components/show_product_details_dialog.dart';
import '../../../Controllers/Main_Controllers/Trade_and_EWaste_SubPages/product_details_controller.dart';
import '../../../Models/wishlist.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/main_colors.dart';
import '../../../Utils/Ads/admob_ids.dart';
import '../../../Utils/Ads/load_ads.dart';
import '../../../Utils/Firebase_Functions/firebase_function.dart';
import '../../../main.dart';
import '../../../objectbox.g.dart';

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
    FirebaseFunctions().getUserPoints(
        context, controller, FirebaseAuth.instance.currentUser!.uid);
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
    Box<WishlistModel> wishlist = objectBox.store.box<WishlistModel>();

    String category =
        Get.arguments[TradeFormModel().cat] == "E-Waste" ? "EWaste" : "Trade";
    String id = Get.arguments[TradeFormModel().productId];
    controller.changeWishlist(false);
    controller.addProductId(Get.arguments[TradeFormModel().productId]);

    for (WishlistModel item in wishlist.getAll()) {
      if (item.productId == Get.arguments[TradeFormModel().productId]) {
        controller.changeWishlist(true);
      }
    }
    void startTrade() async {
      controller.startLoading(true);
      await FirebaseFunctions().addActiveTrade(
          context, FirebaseAuth.instance.currentUser!.uid, id, category);
      Get.offAllNamed(Routes().confirmationScreen);
      controller.startLoading(false);
    }

    void addToWishlist() {
      WishlistModel model = WishlistModel(
          id: 0,
          productCategory: category,
          productId: Get.arguments[TradeFormModel().productId]);

      wishlist.put(model);
      controller.changeWishlist(true);
    }

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                const TopRow(
                  text: "Product Details",
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
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Trading With : ",
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            fontFamily: "bold"),
                                                  ),
                                                  Text(
                                                    Get.arguments[
                                                        TradeFormModel()
                                                            .tradeWith],
                                                    style: context
                                                        .textTheme.bodyMedium,
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "User Points : ",
                                                    style: context
                                                        .textTheme.bodyMedium!
                                                        .copyWith(
                                                            fontFamily: "bold"),
                                                  ),
                                                  Obx(
                                                    () => controller.userPoints
                                                            .value.isEmpty
                                                        ? const CircularProgressIndicator()
                                                        : Text(
                                                            controller
                                                                .userPoints
                                                                .value,
                                                            style: context
                                                                .textTheme
                                                                .bodyMedium,
                                                          ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
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
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0),
                                          child: FirebaseAuth.instance
                                                      .currentUser!.uid ==
                                                  Get.arguments[
                                                      TradeFormModel().userId]
                                              ? Text(
                                                  "You cannot bid or Trade on/with your own product",
                                                  style: context
                                                      .textTheme.bodyLarge,
                                                )
                                              : Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Obx(
                                                      () => ProductButton()
                                                          .newProductButton(
                                                              context.textTheme,
                                                              size,
                                                              controller.isProductinWishlist.value
                                                                  ? "Already Added"
                                                                  : "Add to Wishlist",
                                                              UniconsLine.heart,
                                                              controller
                                                                      .isProductinWishlist
                                                                      .value
                                                                  ? null
                                                                  : () {
                                                                      addToWishlist();
                                                                    },
                                                              controller
                                                                      .isProductinWishlist
                                                                      .value
                                                                  ? AppColors()
                                                                      .secHalfGrey
                                                                  : AppColors()
                                                                      .secRed),
                                                    ),
                                                    ProductButton()
                                                        .newProductButton(
                                                            context.textTheme,
                                                            size,
                                                            "Start Trade",
                                                            UniconsLine.podium,
                                                            () {
                                                      ProductDetailsDialog()
                                                          .showADialog(
                                                              context,
                                                              context.textTheme,
                                                              size, () {
                                                        startTrade();
                                                      }, controller);
                                                    }, AppColors().primaryBlue),
                                                  ],
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
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
