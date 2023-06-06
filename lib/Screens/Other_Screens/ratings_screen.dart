import 'package:barter_x/Components/main_button.dart';
import 'package:barter_x/Controllers/Main_Controllers/Trade_and_EWaste_SubPages/ratings_controller.dart';
import 'package:barter_x/Routes/routes.dart';
import 'package:barter_x/Themes/main_colors.dart';
import 'package:barter_x/Utils/Firebase_Functions/firebase_function.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatingsScreen extends StatefulWidget {
  const RatingsScreen({super.key});

  @override
  State<RatingsScreen> createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen> {
  RatingsController controller = Get.find<RatingsController>();

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
              padding: const EdgeInsets.only(top: 10),
              child: SizedBox(
                  width: size.width,
                  height: 50,
                  child: Center(
                    child: Text("Ratings Screen",
                        style: context.textTheme.bodyLarge),
                  )),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rate User",
                        style: context.textTheme.bodyLarge!
                            .copyWith(fontFamily: "bold")),
                    Obx(
                      () => Slider(
                          value: controller.value.value,
                          label: controller.value.value.toString(),
                          max: 5,
                          min: -1,
                          divisions: 6,
                          activeColor: AppColors().secGreen,
                          inactiveColor: AppColors().primaryBlack,
                          onChanged: (double val) {
                            controller.setvalue(val);
                          }),
                    ),
                    Obx(
                    ()=> MainButton(
                          size: size,
                          actionFunction: () async {
                            controller.startLoading(true);
                            await FirebaseFunctions()
                                .rateUser(controller.value.value, Get.arguments);
                            Get.offAllNamed(Routes().navigationScreen);
                            controller.startLoading(false);
                          },
                          buttonText: "Rate User",
                          mainController: controller.isLoading.value),
                    ),
                    MainButton(
                        size: size,
                        actionFunction: () {
                          Get.offAllNamed(Routes().navigationScreen);
                        },
                        buttonText: "Nevermind",
                        mainController: false),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
