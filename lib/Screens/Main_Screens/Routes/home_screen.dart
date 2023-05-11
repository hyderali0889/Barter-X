import 'package:barter_x/Models/trade_form_model.dart';
import 'package:barter_x/Themes/main_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:unicons/unicons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Components/bottom_app_bar.dart';
import '../../../Components/placeholder_widget.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/home_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/spacing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController controller = Get.find<HomeController>();
  TextEditingController searchController = TextEditingController();

  void getFirebaseTradeData() async {
    Future<QuerySnapshot<Map<String, dynamic>>> data =
        FirebaseFirestore.instance.collection("Trade").get();
    controller.addTradeData(data);
  }

  @override
  void initState() {
    super.initState();
    getFirebaseTradeData();
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

    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              getFirebaseTradeData();
            },
            child: ListView(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: Spacing().sm),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: Text(
                                "Barter X",
                                style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors().primaryBlue,
                                    fontFamily: "bold"),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: InkWell(
                                      onTap: () {},
                                      child: const Icon(UniconsLine.bell)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 20.0),
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
                          child: FutureWidget(
                        controller: controller,
                        size: size,
                        searchController: searchController,
                      ))
                    ],
                  ),
                ),
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
    return Obx(
      () => FutureBuilder(
          future: controller.data.value,
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> data) {
            if (data.hasData && data.data!.docs.isEmpty) {
              return PlaceHolderWidget(
                size: size,
                image: "A6",
                mainText:
                    "Barter Screen is where you enlist a product to be traded with a specific object. ",
                buttonText: "Start a Trade",
                isLoading: false,
                buttonFunc: () {
                  Get.toNamed(Routes().addTradeForm);
                },
              );
            }

            return MainView(
              size: size,
              editingController: searchController,
            );
          }),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required this.size,
    required this.editingController,
  });
  final Size size;
  final TextEditingController editingController;

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
        Padding(
          padding: EdgeInsets.only(top: Spacing().md),
          child: Container(
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
          ),
        ),
        Padding(
            padding: EdgeInsets.only(top: Spacing().md),
            child: SizedBox(
              width: 380,
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: index == 2 ? 0 : 15.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset("assets/cards/Barter$index.png"),
                    ),
                  );
                }),
              ),
            )),
        Padding(
          padding: EdgeInsets.only(top: Spacing().sm),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Categories",
                  style: context.textTheme.bodyMedium!
                      .copyWith(fontFamily: "bold"),
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
                )
              ]),
        )
      ],
    );
  }
}
