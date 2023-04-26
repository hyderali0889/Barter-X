import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';


import '../../Components/placeholder_widget.dart';
import '../../Components/top_row_no_back.dart';
import '../../Controllers/Main_Controllers/EWaste_controller.dart';

class EWasteScreen extends StatefulWidget {
  const EWasteScreen({super.key});

  @override
  State<EWasteScreen> createState() => _EWasteScreenState();
}

class _EWasteScreenState extends State<EWasteScreen> {

  
  EWasteController controller = Get.find<EWasteController>();

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
            TopRowNoBack(
              text: "E-Wastes",
              icon: UniconsLine.shopping_cart_alt,
              firstFunc: () {},
            ),
            Expanded(
                child: PlaceHolderWidget(
              size: size,
              image: "A8",
              mainText: "No EWaste Products Found in your area.",
              buttonText: "Start a Trade",
              isLoading: false,
              buttonFunc: () {},
            )),
          ],
        ),
      )),
    );
  }
}
