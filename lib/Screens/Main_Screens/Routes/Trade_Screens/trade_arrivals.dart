import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../../Components/top_row.dart';
import '../../../../Models/trade_form_model.dart';
import '../../../../Themes/main_colors.dart';

class TradeArrivals extends StatefulWidget {
  const TradeArrivals({super.key});

  @override
  State<TradeArrivals> createState() => _TradeArrivalsState();
}

class _TradeArrivalsState extends State<TradeArrivals> {
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
            TopRow(
              text: "New Arrivals",
              icon: UniconsLine.shopping_cart_alt,
              firstFunc: () {},
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.9,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 50,
                      mainAxisExtent: 300),
                  scrollDirection: Axis.vertical,
                  itemCount: Get.arguments.data!.docs.length - 1,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: DataWidgetRow(
                          size: size,
                          data: Get.arguments,
                          index: (Get.arguments.data!.docs.length - 1) - index),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )),
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
      child: Container(
        decoration: BoxDecoration(
            color: AppColors().secDarkGrey,
            borderRadius: BorderRadius.circular(10)),
        width: size.width * 0.38,
        height: 200,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    data.data!.docs[index][TradeFormModel().img],
                    width: size.width * 0.35,
                    height: 136,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Container(
                  width: size.width * 0.38,
                  height: 20,
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
                height: 80,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
}
