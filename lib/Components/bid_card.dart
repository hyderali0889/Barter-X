import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

        if(snapshot.data!.docs[index][TradeFormModel().userId] == FirebaseAuth.instance.currentUser!.uid){
             Get.toNamed(Routes().bidDetailsScreen,
            arguments: snapshot.data!.docs[index]);
         }else{
 Get.offAllNamed(Routes().bidDetailsScreen,
            arguments: snapshot.data!.docs[index]);
          }

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
              Text(
                snapshot.data!.docs[index][TradeFormModel().isAccepted]
                    ? "Accepted ✔"
                    : "Not yet Accepted ❌",
                style: context.textTheme.bodySmall!.copyWith(
                    fontFamily: "bold",
                    color: snapshot.data!.docs[index]
                            [TradeFormModel().isAccepted]
                        ? AppColors().secGreen
                        : AppColors().secRed),
              ),
            ],
          )),
    );
  }
}
