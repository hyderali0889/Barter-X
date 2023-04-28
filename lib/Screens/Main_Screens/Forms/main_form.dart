import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../../Components/bottom_app_bar.dart';
import '../../../Components/top_row.dart';
import '../../../Controllers/Main_Controllers/Form_Controllers/main_form_controller.dart';

class MainForm extends StatefulWidget {
  const MainForm({super.key});

  @override
  State<MainForm> createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  MainFormController controller = Get.find<MainFormController>();

  void closeBottomBar() {
    controller.changeErrorStatus(false);
  }

  void tryAgainBottomBar() {
    controller.changeErrorStatus(false);
  }

  @override
  Widget build(BuildContext context) {
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
                TopRow(
                  text: "Add Trade",
                  firstFunc: () {},
                  icon: UniconsLine.bell,
                )
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
