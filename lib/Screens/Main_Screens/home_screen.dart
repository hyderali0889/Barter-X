import 'package:barter_x/Themes/main_colors.dart';
import 'package:unicons/unicons.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/placeholder_widget.dart';
import '../../Controllers/Main_Controllers/home_controller.dart';
import '../../Themes/spacing.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {




  HomeController controller = Get.find<HomeController>();
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
                      "Barter X",
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors().primaryBlue, fontFamily: "bold"),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: InkWell(
                            onTap: () {}, child: const Icon(UniconsLine.bell)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                            onTap: () {},
                            child: const Icon(
                              UniconsLine.shopping_cart_alt,
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
                child: PlaceHolderWidget(
              size: size,
              image: "A6",
              mainText: "No Trades Found in your area.",
              buttonText: "Start a Trade",
              isLoading: false,
              buttonFunc: () {},
            ))
          ],
        ),
      )),
    );
  }
}
