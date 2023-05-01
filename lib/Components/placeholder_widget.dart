import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'main_button.dart';

class PlaceHolderWidget extends StatelessWidget {
  const PlaceHolderWidget(
      {super.key,
      required this.size,
      required this.image,
      required this.mainText,
      required this.buttonText,
      required this.buttonFunc,
      required this.isLoading});

  final Size size;
  final String image;
  final String mainText;
  final String buttonText;
  final VoidCallback buttonFunc;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/icons/$image.png",
          height: 350,
          width: 350,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            mainText,
            style: context.textTheme.bodyMedium,
          ),
        ),
        MainButton(
            size: size,
            buttonText: buttonText,
            actionFunction: buttonFunc,
            mainController: isLoading)
      ],
    );
  }
}
