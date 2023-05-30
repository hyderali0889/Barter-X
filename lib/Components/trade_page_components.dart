import 'package:barter_x/Components/placeholder_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';

import '../Models/trade_form_model.dart';
import '../Routes/routes.dart';
import '../Themes/main_colors.dart';
import '../Themes/spacing.dart';
import '../Utils/Generators/random_number_generator.dart';

class FutureWidget extends StatelessWidget {
  const FutureWidget(
      {super.key,
      required this.controller,
      required this.size,
      required this.searchController});

  final dynamic controller;
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
  final dynamic controller;

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
                SpecialProducts(
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
                  return InkWell(
                    onTap: () {
                      Get.toNamed(Routes().categoryDetails,
                          arguments: [categories[index]]);
                    },
                    child: Column(
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
                    ),
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
    Key? key,
    required this.controller,
    required this.size,
    required this.data,
  }) : super(key: key);
  final dynamic controller;
  final Size size;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;

  @override
  Widget build(BuildContext context) {
    Set<int> randomNumbers = data.data == null
        ? {}
        : generateRandomNumbers(
            data.data!.docs.length - 1, 0, data.data!.docs.length - 1);

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
              onTap: () {
                Get.toNamed(Routes().tradeFeature, arguments: data);
              },
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
        Obx(
          () => Padding(
            padding: EdgeInsets.only(top: Spacing().sm),
            child: controller.isRefreshing.value ||
                    data.data == null ||
                    data.data!.docs.length.toString().isEmpty
                ? Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height * 0.3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            MainShimmerContainer(
                              data: data,
                              controller: controller,
                              size: size,
                            ),
                            MainShimmerContainer(
                              data: data,
                              controller: controller,
                              size: size,
                            ),
                          ],
                        ),
                      ),
                      LongShimmerContainer(
                        controller: controller,
                        data: data,
                        size: size,
                      )
                    ],
                  )
                : Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: data.data!.docs.length < 3
                            ? size.height * 0.35
                            : size.height * 0.58,
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width,
                              height: size.height * 0.35,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.data!.docs.length > 2 ? 2 : 1,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    child: DataWidgetRow(
                                        size: size,
                                        data: data,
                                        index: randomNumbers.elementAt(index)),
                                  );
                                },
                              ),
                            ),
                            data.data!.docs.length < 3
                                ? Container()
                                : InkWell(
                                    child: DataWidgetLength(
                                        size: size,
                                        data: data,
                                        rand: randomNumbers),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
  final dynamic controller;
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
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontFamily: "bold"),
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(Routes().tradeArrivals, arguments: data);
                  },
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
          Obx(() => Padding(
                padding: EdgeInsets.only(top: Spacing().sm),
                child: controller.isRefreshing.value ||
                        data.data == null ||
                        data.data!.docs.length.toString().isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: Spacing().sm),
                        child: SizedBox(
                          width: size.width,
                          height: size.height * 0.35,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MainShimmerContainer(
                                data: data,
                                controller: controller,
                                size: size,
                              ),
                              MainShimmerContainer(
                                data: data,
                                controller: controller,
                                size: size,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            width: size.width,
                            height: size.height * 0.35,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.data!.docs.length > 2 ? 2 : 1,
                              itemBuilder: (context, index) {
                                return DataWidgetRow(
                                    size: size,
                                    data: data,
                                    index:
                                        (data.data!.docs.length - 1) - index);
                              },
                            ),
                          ),
                        ],
                      ),
              ))
        ]);
  }
}

class SpecialProducts extends StatelessWidget {
  const SpecialProducts({
    super.key,
    required this.data,
    required this.controller,
    required this.size,
  });
  final dynamic controller;
  final Size size;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;

  @override
  Widget build(BuildContext context) {
    Set<int> randomNumbers = data.data == null
        ? {}
        : generateRandomNumbers(
            data.data!.docs.length - 1, 0, data.data!.docs.length - 1);

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
                "Special Offers",
                style:
                    context.textTheme.bodyMedium!.copyWith(fontFamily: "bold"),
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(Routes().tradeSpecials, arguments: data);
                },
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
        Obx(() => Padding(
            padding: EdgeInsets.only(top: Spacing().sm),
            child: controller.isRefreshing.value ||
                    data.data == null ||
                    data.data!.docs.length.toString().isEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: Spacing().sm),
                    child: Column(
                      children: [
                        SizedBox(
                          width: size.width,
                          height: size.height * 0.3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              MainShimmerContainer(
                                data: data,
                                controller: controller,
                                size: size,
                              ),
                              MainShimmerContainer(
                                data: data,
                                controller: controller,
                                size: size,
                              ),
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
                : Column(
                    children: [
                      SizedBox(
                        width: size.width,
                        height: data.data!.docs.length < 3
                            ? size.height * 0.35
                            : size.height * 0.58,
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width,
                              height: size.height * 0.35,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.data!.docs.length > 2 ? 2 : 1,
                                itemBuilder: (context, index) {
                                  return DataWidgetRow(
                                      size: size,
                                      data: data,
                                      index: randomNumbers.elementAt(index));
                                },
                              ),
                            ),
                            data.data!.docs.length < 3
                                ? Container()
                                : DataWidgetLength(
                                    size: size,
                                    data: data,
                                    rand: randomNumbers),
                          ],
                        ),
                      ),
                    ],
                  ))),
      ],
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

  final dynamic controller;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;
  final Size size;

  @override
  Widget build(BuildContext context) {
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
  final dynamic controller;
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
              Obx(() => Shimmer(
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
                  ))),
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

class DataWidgetRow extends StatelessWidget {
  const DataWidgetRow({
    super.key,
    required this.size,
    required this.data,
    required this.index,
  });

  final Size size;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes().productDetails, arguments: data);
        },
        child: Container(
          decoration: BoxDecoration(
              color: AppColors().secSoftGrey,
              borderRadius: BorderRadius.circular(10)),
          width: size.width * 0.38,
          height: size.height * 0.4,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        placeholder: ((context, url) {
                          return Lottie.asset("assets/jsons/atom-loader.json");
                        }),
                        imageUrl: data.data!.docs[index][TradeFormModel().img],
                        width: size.width * 0.35,
                        height: 140,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Container(
                    width: size.width * 0.38,
                    height: 50,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Text(data.data!.docs[index][TradeFormModel().title],
                        overflow: TextOverflow.fade,
                        style: context.textTheme.bodySmall!
                            .copyWith(fontFamily: "bold")),
                  ),
                ),
                Container(
                  width: size.width * 0.38,
                  height: 70,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Trading With :",
                          overflow: TextOverflow.fade,
                          style: context.textTheme.bodySmall),
                      Text(data.data!.docs[index][TradeFormModel().tradeWith],
                          style: context.textTheme.bodySmall),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DataWidgetLength extends StatelessWidget {
  const DataWidgetLength({
    super.key,
    required this.size,
    required this.data,
    required this.rand,
  });

  final Size size;
  final AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data;
  final Set rand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0),
      child: InkWell(
        onTap: () {
          Get.toNamed(Routes().productDetails, arguments: data);
        },
        child: Container(
          width: size.width * 0.9,
          height: size.height * 0.2,
          decoration: BoxDecoration(
              color: AppColors().secSoftGrey,
              borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        placeholder: ((context, url) {
                          return Lottie.asset("assets/jsons/atom-loader.json");
                        }),
                        imageUrl: data.data!.docs[rand.elementAt(3)]
                            [TradeFormModel().img],
                        width: size.width * 0.35,
                        height: 136,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            width: size.width * 0.4,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                                data.data!.docs[rand.elementAt(3)]
                                    [TradeFormModel().title],
                                overflow: TextOverflow.fade,
                                style: context.textTheme.bodySmall!
                                    .copyWith(fontFamily: "bold"))),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Container(
                              width: size.width * 0.4,
                              height: 40,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                children: [
                                  Text(
                                    "Trading With : ",
                                    overflow: TextOverflow.fade,
                                    style: context.textTheme.bodySmall,
                                  ),
                                  Text(
                                      data.data!.docs[rand.elementAt(3)]
                                          [TradeFormModel().tradeWith],
                                      overflow: TextOverflow.fade,
                                      style: context.textTheme.bodySmall),
                                ],
                              )),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
