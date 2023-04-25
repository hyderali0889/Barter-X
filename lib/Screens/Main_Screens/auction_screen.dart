import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../Components/main_button.dart';
import '../../Themes/main_colors.dart';
import '../../Themes/spacing.dart';

class AuctionScreen extends StatefulWidget {
  const AuctionScreen({super.key});

  @override
  State<AuctionScreen> createState() => _AuctionScreenState();
}

class _AuctionScreenState extends State<AuctionScreen> {
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
                      "Auctions",
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
                    "assets/icons/A7.png",
                    height: 350,
                    width: 350,
                  ),
                  Text(
                    "No Auctions Found In Your Area",
                    style: context.textTheme.bodySmall,
                  ),
                  MainButton(
                      size: size,
                      buttonText: "Start a Trade",
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
