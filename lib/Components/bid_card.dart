import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Models/trade_form_model.dart';
import '../Routes/routes.dart';
import '../Themes/main_colors.dart';

class BidCard extends StatelessWidget {
  const BidCard({super.key, required this.snapshot, required this.index});
  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes().bidDetailsScreen,
            arguments: snapshot.data!.docs[index]);
      },
      child: Container(
          height: 280,
          width: 140,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColors().secDarkGrey,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: CachedNetworkImage(
                  height: 120,
                  width: 80,
                  imageUrl: snapshot.data!.docs[index][TradeFormModel().img],
                  placeholder: (context, url) {
                    return Lottie.asset("assets/jsons/atom-loader.json");
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text(
                  snapshot.data!.docs[index][TradeFormModel().title],
                  maxLines: 1,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Bid By : ",
                    style: context.textTheme.bodySmall,
                  ),
                  Text(
                      snapshot.data!.docs[index][TradeFormModel().email]
                          .toString()
                          .split("@")[0],
                      maxLines: 1,
                      style: context.textTheme.bodySmall),
                ],
              ),
            ],
          )),
    );

  }
}
