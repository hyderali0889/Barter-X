import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../Components/main_button.dart';
import '../../Themes/main_colors.dart';
import '../../Themes/spacing.dart';

class EWasteScreen extends StatefulWidget {
  const EWasteScreen({super.key});

  @override
  State<EWasteScreen> createState() => _EWasteScreenState();
}

class _EWasteScreenState extends State<EWasteScreen> {
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
            Padding(
              padding: EdgeInsets.only(top: Spacing().sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(),
                  Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Text(
                      "E-Wastes",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors().primaryBlack,
                          fontFamily: "medium"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: InkWell(
                        onTap: () {},
                        child: const Icon(
                          UniconsLine.shopping_cart_alt,
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/icons/A8.png",
                    height: 350,
                    width: 350,
                  ),
                  Text(
                    "No E-Waste Found In Your Area",
                    style: context.textTheme.bodySmall,
                  ),
                  MainButton(
                      size: size,
                      buttonText: "Start an Auction",
                      actionFunction: () {},
                      mainController: false)
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
