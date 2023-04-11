import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../Themes/main_colors.dart';
import '../Themes/spacing.dart';

class MainButton extends StatelessWidget {
  const MainButton(
      {super.key,
      required this.size,
      required this.buttonText,
      required this.actionFunction,
      required this.mainController});

  final Size size;
  final bool mainController;

  final String buttonText;
  final VoidCallback actionFunction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: Spacing().md),
          child: InkWell(
            onTap: mainController ? null : actionFunction,
            child: Container(
              alignment: Alignment.center,
              width: size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                  color: mainController
                      ? AppColors().secHalfGrey
                      : AppColors().primaryBlue,
                  borderRadius: BorderRadius.circular(10)),
              child: mainController
                  ? Lottie.asset("assets/jsons/atom-loader.json")
                  : Text(
                      buttonText,
                      style: context.textTheme.displayMedium,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
