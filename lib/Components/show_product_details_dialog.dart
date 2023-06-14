import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/Main_Controllers/Trade_and_EWaste_SubPages/product_details_controller.dart';
import 'main_button.dart';

class ProductDetailsDialog {
  Future<dynamic> showADialog(
      context, textTheme, Size size, func, ProductDetailsController isActive) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: SizedBox(
              width: size.width * 0.7,
              height: size.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(children: [
                  Text("Rules and Regulations",
                      style: textTheme.bodyLarge!.copyWith(fontFamily: "bold")),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: Text(
                      "1. Please Trade in a safe place under police supervision or under surveillance \n 2. Please make sure you are getting your product in the desired condition. \n 3. Please check the condition of the product and leave appropriate review for the trader. \n 4.Your Reviews helps others in choosing the right Trader. \n 5. This app provides the option to mark Scammers please identify Scammers while adding Review.",
                      style: textTheme.bodyMedium!,
                    ),
                  ),
                  Obx(
                    () => MainButton(
                      actionFunction: func,
                      buttonText: "Start Trade",
                      mainController: isActive.isLoading.value,
                      size: size,
                    ),
                  ),
                ]),
              ),
            ),
          );
        });
  }
}
