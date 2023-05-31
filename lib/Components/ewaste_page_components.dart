import 'package:barter_x/Components/placeholder_widget.dart';
import 'package:barter_x/Components/trade_page_components.dart' as trade;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Routes/routes.dart';
import '../Themes/spacing.dart';

class EWasteFutureWidget extends StatelessWidget {
  const EWasteFutureWidget(
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
                    image: "A8",
                    mainText:
                        "This is a special section to reduce the E-Waste from the environment.",
                    buttonText: "Start a Trade",
                    isLoading: false,
                    buttonFunc: () {
                      Get.toNamed(Routes().addEWasteForm);
                    },
                  )),
                );
              }

              return EWasteMainView(
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

class EWasteMainView extends StatelessWidget {
  const EWasteMainView({
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
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          trade.SearchBar(size: size, editingController: editingController),
          EWasteImageArea(
            size: size,
          ),
          Padding(
            padding: EdgeInsets.only(top: Spacing().sm),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  trade.FeaturedProducts(
                    size: size,
                    data: data,
                    controller: controller,
                  ),
                  trade.NewArrivals(
                    size: size,
                    data: data,
                    controller: controller,
                  ),
                  trade.SpecialProducts(
                    size: size,
                    data: data,
                    controller: controller,
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}

class EWasteImageArea extends StatelessWidget {
  const EWasteImageArea({
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
                  child: Image.asset("assets/cards/Ewaste$index.png"),
                ),
              );
            }),
          ),
        ));
  }
}
