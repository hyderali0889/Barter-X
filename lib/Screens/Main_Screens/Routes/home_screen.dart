import 'package:barter_x/Themes/main_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Components/bottom_app_bar.dart';
import '../../../Components/placeholder_widget.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/home_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/spacing.dart';
import '../../../Utils/admob_ids.dart';
import '../../../Utils/firebase_function.dart';

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
      controller.changeErrorMessage(e.message.toString());
      controller.changeErrorStatus(true);
    }
  }

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void closeBottomBar() {
      controller.changeErrorStatus(false);
    }

    void tryAgainBottomBar() {
      controller.changeErrorStatus(false);
      loadAd();
    }

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
                                    : Container()
                              ]),
                            )
                          ],
                        ),
                      ),
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

class FutureWidget extends StatelessWidget {
  const FutureWidget(
      {super.key,
      required this.controller,
      required this.size,
      required this.searchController});

  final HomeController controller;
  final Size size;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Obx(
        () => FutureBuilder(
            future: controller.data.value,
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data) {
              if (data.hasData && data.data!.docs.isEmpty) {
                return SizedBox(
                  width: size.width,
                  height: size.height * 0.82,
                  child: Center(
                    child: PlaceHolderWidget(
                      size: size,
                      image: "A6",
                      mainText:
                          "Barter Screen is where you enlist a product to be traded with a specific object. ",
                      buttonText: "Start a Trade",
                      isLoading: false,
                      buttonFunc: () {
                        Get.toNamed(Routes().addTradeForm);
                      },
                    ),
                  ),
                );
              }

              return MainView(
                controller: controller,
                data: data,
                size: size,
                editingController: searchController,
              );
            }),
      ),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required this.size,
    required this.editingController,
    required this.data,
    required this.controller,
  });
  final Size size;
  final TextEditingController editingController;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;
  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    List<String> categories = [
      "Books",
      "Furniture",
      "Glass-Items",
      "Clothing",
      "Car",
      "Motorcycle",
      "Toys",
      "Others",
    ];
    List<IconData> icons = [
      UniconsLine.book,
      UniconsLine.table,
      UniconsLine.glass_martini,
      UniconsLine.water,
      UniconsLine.car,
      UniconsLine.circle,
      UniconsLine.anchor,
      UniconsLine.times
    ];
    List<Color> colours = [
      AppColors().labelOffRed,
      AppColors().primaryYellow,
      AppColors().secRed,
      AppColors().primaryPurple,
      AppColors().labelOffBlue,
      AppColors().labelOffGreen,
      AppColors().secGreen,
      AppColors().secHalfGrey
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SearchBar(size: size, editingController: editingController),
        ImageArea(
          size: size,
        ),
        Padding(
          padding: EdgeInsets.only(top: Spacing().sm),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CategoryArea(
                    size: size,
                    categories: categories,
                    colours: colours,
                    icons: icons),
                FeaturedProducts(
                  size: size,
                  data: data,
                  controller: controller,
                ),
                NewArrivals(
                  size: size,
                  data: data,
                  controller: controller,
                ),
                TopRatedProducts(
                  size: size,
                  data: data,
                  controller: controller,
                ),
              ]),
        ),
      ],
    );
  }
}

/*
 █████╗ ██╗     ██╗          ██████╗ ██████╗ ███╗   ███╗██████╗  ██████╗ ███╗   ██╗███████╗███╗   ██╗████████╗███████╗
██╔══██╗██║     ██║         ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██╔═══██╗████╗  ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
███████║██║     ██║         ██║     ██║   ██║██╔████╔██║██████╔╝██║   ██║██╔██╗ ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
██╔══██║██║     ██║         ██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║   ██║██║╚██╗██║██╔══╝  ██║╚██╗██║   ██║   ╚════██║
██║  ██║███████╗███████╗    ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ╚██████╔╝██║ ╚████║███████╗██║ ╚████║   ██║   ███████║
╚═╝  ╚═╝╚══════╝╚══════╝     ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝

*/

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.size,
    required this.editingController,
  });

  final Size size;
  final TextEditingController editingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors().secSoftGrey,
          borderRadius: BorderRadius.circular(20)),
      height: size.height * 0.06,
      width: size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: TextFormField(
          controller: editingController,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              suffixIcon: const Icon(
                UniconsLine.search,
                size: 14,
              ),
              hintText: "Search Product Name",
              hintStyle: context.textTheme.bodySmall!
                  .copyWith(color: AppColors().secHalfGrey),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none),
        ),
      ),
    );
  }
}

class ImageArea extends StatelessWidget {
  const ImageArea({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: Spacing().md),
        child: SizedBox(
          width: size.width,
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 3,
            itemBuilder: ((context, index) {
              return Padding(
                padding: EdgeInsets.only(
                    right: index == 2 ? size.width * 0.05 : size.width * 0.13),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset("assets/cards/Barter$index.png"),
                ),
              );
            }),
          ),
        ));
  }
}

class CategoryArea extends StatelessWidget {
  const CategoryArea({
    super.key,
    required this.size,
    required this.categories,
    required this.colours,
    required this.icons,
  });

  final Size size;
  final List<String> categories;
  final List<Color> colours;
  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: context.textTheme.bodyMedium!.copyWith(fontFamily: "bold"),
        ),
        Padding(
          padding: EdgeInsets.only(top: Spacing().sm - 10),
          child: SizedBox(
            height: 150,
            width: size.width * 0.9,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                              color: colours[index],
                              borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            icons[index],
                            size: 30,
                            color: AppColors().labelOffBlack,
                          ),
                        ),
                      ),
                      Text(
                        categories[index],
                        style: context.textTheme.bodySmall,
                      )
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }
}

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({
    super.key,
    required this.data,
    required this.controller,
    required this.size,
  });
  final HomeController controller;
  final Size size;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Featured Products",
              style: context.textTheme.bodyMedium!.copyWith(fontFamily: "bold"),
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 30.0),
                child: Text(
                  "See All",
                  style: context.textTheme.bodySmall!
                      .copyWith(color: AppColors().primaryBlue),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: Spacing().sm),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 260,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MainShimmerContainer(
                        data: data, controller: controller, size: size),
                    MainShimmerContainer(
                        data: data, controller: controller, size: size),
                  ],
                ),
              ),
              LongShimmerContainer(
                controller: controller,
                data: data,
                size: size,
              )
            ],
          ),
        )
      ],
    );
  }
}

class NewArrivals extends StatelessWidget {
  const NewArrivals({
    super.key,
    required this.data,
    required this.controller,
    required this.size,
  });
  final HomeController controller;
  final Size size;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: Spacing().lg),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "New Arrivals",
                style:
                    context.textTheme.bodyMedium!.copyWith(fontFamily: "bold"),
              ),
              InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: Text(
                    "See All",
                    style: context.textTheme.bodySmall!
                        .copyWith(color: AppColors().primaryBlue),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Spacing().sm),
          child: SizedBox(
            width: size.width,
            height: 260,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MainShimmerContainer(
                    data: data, controller: controller, size: size),
                MainShimmerContainer(
                    data: data, controller: controller, size: size),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class TopRatedProducts extends StatelessWidget {
  const TopRatedProducts({
    super.key,
    required this.data,
    required this.controller,
    required this.size,
  });
  final HomeController controller;
  final Size size;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Spacing().lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: Spacing().lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Top Rated Products",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontFamily: "bold"),
                ),
                InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(right: 30.0),
                    child: Text(
                      "See All",
                      style: context.textTheme.bodySmall!
                          .copyWith(color: AppColors().primaryBlue),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: Spacing().sm),
            child: Column(
              children: [
                SizedBox(
                  width: size.width,
                  height: 260,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MainShimmerContainer(
                          data: data, controller: controller, size: size),
                      MainShimmerContainer(
                          data: data, controller: controller, size: size),
                    ],
                  ),
                ),
                LongShimmerContainer(
                  controller: controller,
                  data: data,
                  size: size,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

/*
 █████╗ ██╗     ██╗         ███████╗██╗   ██╗██████╗        ██████╗ ██████╗ ███╗   ███╗██████╗  ██████╗ ███╗   ██╗███████╗███╗   ██╗████████╗███████╗
██╔══██╗██║     ██║         ██╔════╝██║   ██║██╔══██╗      ██╔════╝██╔═══██╗████╗ ████║██╔══██╗██╔═══██╗████╗  ██║██╔════╝████╗  ██║╚══██╔══╝██╔════╝
███████║██║     ██║         ███████╗██║   ██║██████╔╝█████╗██║     ██║   ██║██╔████╔██║██████╔╝██║   ██║██╔██╗ ██║█████╗  ██╔██╗ ██║   ██║   ███████╗
██╔══██║██║     ██║         ╚════██║██║   ██║██╔══██╗╚════╝██║     ██║   ██║██║╚██╔╝██║██╔═══╝ ██║   ██║██║╚██╗██║██╔══╝  ██║╚██╗██║   ██║   ╚════██║
██║  ██║███████╗███████╗    ███████║╚██████╔╝██████╔╝      ╚██████╗╚██████╔╝██║ ╚═╝ ██║██║     ╚██████╔╝██║ ╚████║███████╗██║ ╚████║   ██║   ███████║
╚═╝  ╚═╝╚══════╝╚══════╝    ╚══════╝ ╚═════╝ ╚═════╝        ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚═╝      ╚═════╝ ╚═╝  ╚═══╝╚══════╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝

*/

class LongShimmerContainer extends StatelessWidget {
  const LongShimmerContainer({
    super.key,
    required this.controller,
    required this.data,
    required this.size,
  });

  final HomeController controller;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;
  final Size size;

  @override
  Widget build(BuildContext context) {
    //  bool isRefreshing = controller.isRefreshing.value || !data.hasData;
    return Padding(
      padding: EdgeInsets.only(top: Spacing().sm),
      child: Container(
        width: size.width * 0.9,
        height: 171,
        decoration: BoxDecoration(
            color: AppColors().secDarkGrey,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Shimmer(
                  gradient: LinearGradient(colors: [
                    AppColors().secHalfGrey,
                    AppColors().secSoftGrey
                  ]),
                  enabled: controller.isRefreshing.value || !data.hasData,
                  child: Container(
                    width: 160,
                    height: 20,
                    decoration: BoxDecoration(
                        color: AppColors().secSoftGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Obx(
                  () => Shimmer(
                    gradient: LinearGradient(colors: [
                      AppColors().secHalfGrey,
                      AppColors().secSoftGrey
                    ]),
                    enabled: controller.isRefreshing.value || !data.hasData,
                    child: Container(
                      width: 98,
                      height: 10,
                      decoration: BoxDecoration(
                          color: AppColors().secSoftGrey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MainShimmerContainer extends StatelessWidget {
  const MainShimmerContainer({
    super.key,
    required this.data,
    required this.controller,
    required this.size,
  });
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;
  final HomeController controller;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors().secDarkGrey,
            borderRadius: BorderRadius.circular(10)),
        width: size.width * 0.38,
        height: 242,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => Shimmer(
                  gradient: LinearGradient(colors: [
                    AppColors().secHalfGrey,
                    AppColors().secSoftGrey
                  ]),
                  enabled: controller.isRefreshing.value || !data.hasData,
                  child: Container(
                    width: size.width * 0.35,
                    height: 136,
                    decoration: BoxDecoration(
                        color: AppColors().secSoftGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Obx(
                  () => Shimmer(
                    gradient: LinearGradient(colors: [
                      AppColors().secHalfGrey,
                      AppColors().secSoftGrey
                    ]),
                    enabled: controller.isRefreshing.value || !data.hasData,
                    child: Container(
                      width: 100,
                      height: 20,
                      decoration: BoxDecoration(
                          color: AppColors().secSoftGrey,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Shimmer(
                  gradient: LinearGradient(colors: [
                    AppColors().secHalfGrey,
                    AppColors().secSoftGrey
                  ]),
                  enabled: controller.isRefreshing.value || !data.hasData,
                  child: Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                        color: AppColors().secSoftGrey,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
