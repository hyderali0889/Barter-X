import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Themes/main_colors.dart';
import 'package:unicons/unicons.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.controller,
    required this.size,
  });

  final dynamic controller;
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        bottom: 20,
        left: controller.errorOcurred.value ? 45 : -445,
        duration: const Duration(milliseconds: 500),
        child: Container(
          width: size.width * 0.8,
          height: 250,
          decoration: BoxDecoration(
              color: AppColors().labelOffBlack,
              borderRadius: BorderRadius.circular(14.0)),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Login Error",
                      style: context.textTheme.displayMedium,
                    ),
                    IconButton(
                        onPressed: () {
                          controller.changeErrorStatus(false);

                         }, icon: const Icon(UniconsLine.times))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25.0),
                  child: Text(
                    "We Encountered an error trying to log into your account. Please Check your Network Connection and try again.",
                    style: context.textTheme.displaySmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: InkWell(
                    onTap: () {

                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: size.width * 0.8,
                      height: 50,
                      decoration: BoxDecoration(
                          color: AppColors().primaryBlue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        "Try Again",
                        style: context.textTheme.displaySmall,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
