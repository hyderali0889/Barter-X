import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import '../../../Components/bottom_app_bar.dart';
import '../../../Components/placeholder_widget.dart';
import '../../../Components/top_row_no_back.dart';
import '../../../Controllers/Main_Controllers/Route_Controllers/ewaste_controller.dart';
import '../../../Routes/routes.dart';

class EWasteScreen extends StatefulWidget {
  const EWasteScreen({super.key});

  @override
  State<EWasteScreen> createState() => _EWasteScreenState();
}

class _EWasteScreenState extends State<EWasteScreen> {
  EWasteController controller = Get.find<EWasteController>();

  @override
  Widget build(BuildContext context) {
    void closeBottomBar() {
      controller.changeErrorStatus(false);
    }

    void tryAgainBottomBar() {
      controller.changeErrorStatus(false);
    }

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                TopRowNoBack(
                  text: "E-Wastes",
                  icon: UniconsLine.shopping_cart_alt,
                  firstFunc: () {},
                ),
                Expanded(
                    child: PlaceHolderWidget(
                  size: size,
                  image: "A8",
                  mainText:
                      "This is a special section to reduce the E-Waste from the environment.",
                  buttonText: "Start a Trade",
                  isLoading: false,
                  buttonFunc: () {
                    Get.toNamed(Routes().addTradeForm , arguments: "b");

                   },
                )),
              ],
            ),
          ),
          Obx(
            () => BottomBar(
              controller: controller,
              size: size,
              errorTitle: "An Error Occurred",
              errorMsg: controller.errorMsg.value,
              closeFunction: closeBottomBar,
              tryAgainFunction: tryAgainBottomBar,
              buttonWidget: Text(
                "Try Again",
                style: context.textTheme.displayMedium,
              ),
            ),
          )
        ],
      )),
    );
  }
}
