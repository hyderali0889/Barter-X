import 'package:barter_x/Components/auction_page_components.dart';
import 'package:barter_x/Components/main_button.dart';
import 'package:barter_x/Components/placeholder_widget.dart';
import 'package:barter_x/Components/top_row.dart';
import 'package:barter_x/Components/trade_page_components.dart';
import 'package:barter_x/Models/trade_form_model.dart';
import 'package:barter_x/Utils/Widgets/show_modal_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:unicons/unicons.dart';
import '../../Controllers/Main_Controllers/Other_Controllers/search_controller.dart'
    as sc;

import '../../Themes/main_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchingController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  sc.SearchController controller = Get.find<sc.SearchController>();
  @override
  void initState() {
    super.initState();
    controller.startSearch(false);
  }

  startSearch() {
    controller.startSearch(false);

    if (searchingController.text.isNotEmpty || cityController.text.isNotEmpty) {
      controller.startSearch(true);
    } else {
      controller.startSearch(false);

      ReturnWidgets().returnBottomSheet(context, "Please Add City or Text");
    }
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
            const TopRow(text: "Search Screen"),
            Obx(
              () => Expanded(
                child: controller.isSearchStarted.value
                    ? Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: FutureBuilder(
                            future: cityController.text.isEmpty
                                ? FirebaseFirestore.instance
                                    .collection(Get.arguments)
                                    .where(TradeFormModel().title,
                                        isGreaterThanOrEqualTo:
                                            searchingController.text
                                                .trim()
                                                .capitalize)
                                    .where(TradeFormModel().title,
                                        isLessThan:
                                            "${searchingController.text.trim().capitalize}z")
                                    .get()
                                : searchingController.text.isEmpty
                                    ? FirebaseFirestore.instance
                                        .collection(Get.arguments)
                                        .where(TradeFormModel().district,
                                            isEqualTo: cityController.text
                                                .trim()
                                                .capitalize)
                                        .get()
                                    : FirebaseFirestore.instance
                                        .collection(Get.arguments)
                                        .where(TradeFormModel().title,
                                            isGreaterThanOrEqualTo:
                                                searchingController.text
                                                    .trim()
                                                    .capitalize)
                                        .where(TradeFormModel().title,
                                            isLessThan:
                                                "${searchingController.text.trim().capitalize}z")
                                        .where(TradeFormModel().district,
                                            isEqualTo: cityController.text
                                                .trim()
                                                .capitalize)
                                        .get(),
                            builder: (context,
                                AsyncSnapshot<
                                        QuerySnapshot<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: Lottie.asset(
                                      "assets/jsons/atom-loader.json"),
                                );
                              }
                              if (snapshot.data!.docs.isEmpty) {
                                return PlaceHolderWidget(
                                    size: size,
                                    image: "B6",
                                    mainText: "Nothing Found Here",
                                    buttonText: "Retry",
                                    buttonFunc: () {
                                      controller.startSearch(false);
                                    },
                                    isLoading: false);
                              }
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 50,
                                        mainAxisExtent: 340),
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return Get.arguments == "Auction"
                                      ? AuctionDataWidgetRow(
                                          size: size,
                                          data: snapshot,
                                          index: index)
                                      : DataWidgetRow(
                                          data: snapshot,
                                          size: size,
                                          index: index,
                                        );
                                },
                              );
                            }),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            FormField(
                              searchController: searchingController,
                              text: "Search Product Name",
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: FormField(
                                searchController: cityController,
                                text: "Search by city",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Obx(
                                () => MainButton(
                                  size: size,
                                  buttonText: "Search",
                                  actionFunction: () {
                                    startSearch();
                                  },
                                  mainController:
                                      controller.isSearchStarted.value,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class FormField extends StatefulWidget {
  const FormField({
    super.key,
    required this.searchController,
    required this.text,
  });

  final TextEditingController searchController;
  final String text;

  @override
  State<FormField> createState() => _FormFieldState();
}

class _FormFieldState extends State<FormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors().secSoftGrey,
          borderRadius: BorderRadius.circular(14)),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: TextFormField(
          controller: widget.searchController,
          textAlign: TextAlign.left,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
              suffixIcon: const Icon(
                UniconsLine.search,
                size: 14,
              ),
              hintText: widget.text,
              hintStyle: context.textTheme.bodySmall!
                  .copyWith(color: AppColors().secHalfGrey),
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none),
        ),
      ),
    );
  }
}
