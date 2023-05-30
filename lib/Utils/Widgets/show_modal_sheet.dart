import 'package:barter_x/Components/main_button.dart';
import 'package:barter_x/Themes/main_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReturnWidgets {
  returnBottomSheet(context, String errorText) {
    return showModalBottomSheet(
        backgroundColor: AppColors().primaryBlack,
        elevation: 20,
        useSafeArea: true,
        isDismissible: true,
        context: context,
        builder: (context) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.3,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "An Error Occurred",
                    style: context.textTheme.bodyLarge!
                        .copyWith(color: AppColors().secRed),
                  ),
                  Text(
                    errorText,
                    style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors().primaryWhite, fontFamily: "bold"),
                  ),
                  MainButton(
                      size: MediaQuery.of(context).size,
                      buttonText: "Try Again",
                      actionFunction: () {
                        Get.back();
                      },
                      mainController: false)
                ],
              ),
            ),
          );
        });
  }
}
