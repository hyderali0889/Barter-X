import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Themes/main_colors.dart';
import 'package:unicons/unicons.dart';

import '../Themes/spacing.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.controller,
    required this.size,
    required this.errorMsg,
    required this.closeFunction,
    required this.tryAgainFunction,
    required this.errorTitle,
    required this.buttonWidget,
  });

  final dynamic controller;
  final Size size;
  final String errorTitle;
  final String errorMsg;
  final VoidCallback closeFunction;
  final VoidCallback tryAgainFunction;
  final Widget buttonWidget;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedPositioned(
        bottom: 20,
        left: controller.errorOcurred.value ? size.width * 0.1 : -885,
        duration: const Duration(milliseconds: 500),
        child: Container(
          width: size.width * 0.8,
          height: 300,
          decoration: BoxDecoration(
              color: AppColors().labelOffBlack,
              borderRadius: BorderRadius.circular(14.0)),
          child: Padding(
            padding: EdgeInsets.all(Spacing().sm),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      errorTitle,
                      style: context.textTheme.displayMedium,
                    ),
                    IconButton(
                        onPressed: closeFunction,
                        icon: Icon(
                          UniconsLine.times,
                          color: AppColors().primaryWhite,
                        ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: Spacing().xs),
                  child: Text(
                    errorMsg,
                    style: context.textTheme.displaySmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: Spacing().sm),
                  child: InkWell(
                    onTap: tryAgainFunction,
                    child: Container(
                        alignment: Alignment.center,
                        width: size.width * 0.8,
                        height: 50,
                        decoration: BoxDecoration(
                            color: AppColors().primaryBlue,
                            borderRadius: BorderRadius.circular(10)),
                        child: buttonWidget),
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
