import 'dart:io';
import 'package:barter_x/Components/main_button.dart';
import 'package:barter_x/Utils/Firebase_Functions/add_data_to_firestore.dart';
import 'package:barter_x/Utils/Widgets/form_bottom_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "../../../Routes/routes.dart";
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';
import '../../../Components/form_text_field.dart';
import '../../../Controllers/Main_Controllers/Form_Controllers/bid_form_controller.dart';
import '../../../Models/trade_form_model.dart';
import '../../../Themes/main_colors.dart';
import '../../../Themes/spacing.dart';
import '../../../Utils/Widgets/show_modal_sheet.dart';

class BidForm extends StatefulWidget {
  const BidForm({super.key});

  @override
  State<BidForm> createState() => _BidFormState();
}

class _BidFormState extends State<BidForm> {
  BidFormController controller = Get.find<BidFormController>();

  TextEditingController titleController = TextEditingController();
  TextEditingController bidingOnController =
      TextEditingController(text: Get.arguments[TradeFormModel().productId]);
  TextEditingController desController = TextEditingController();

  TextEditingController userEmailController =
      TextEditingController(text: FirebaseAuth.instance.currentUser!.email);
  TextEditingController userPhoneController = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.phoneNumber);

  @override
  void dispose() {
    titleController.dispose();
    desController.dispose();
    userEmailController.dispose();
    userPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                SizedBox(
                    height: size.height * 0.05,
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: const Icon(UniconsLine.arrow_left),
                          onPressed: () {
                            Get.offAllNamed(Routes().navigationScreen);
                          },
                        ),
                        Text("Add Bids", style: context.textTheme.bodyMedium),
                        Container()
                      ],
                    )),
                Expanded(
                  child: ListView(
                    children: [
                      TheForm(
                        titleController: titleController,
                        desController: desController,
                        userEmailController: userEmailController,
                        userPhoneController: userPhoneController,
                        bidingOnController: bidingOnController,
                        controller: controller,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: Spacing().sm),
                        child: Obx(
                          () => MainButton(
                            size: size,
                            buttonText: "Add Your Bid",
                            actionFunction: () {
                              try {
                                String path = "file/${DateTime.now()}";
                                File file = File(controller.image.value!.path);
                                AddDataToFirestore().addBidToFirestore(
                                    context,
                                    controller,
                                    titleController,
                                    desController,
                                    path,
                                    file,
                                    Get.arguments[TradeFormModel().productId],
                                    Get.arguments[TradeFormModel().district],
                                    Get.arguments[TradeFormModel().cat]);
                              } catch (e) {
                                ReturnWidgets().returnBottomSheet(context,
                                    "An Error Occurred , Please fill all the Fields and try again");
                              }
                            },
                            mainController: controller.isLoading.value,
                          ),
                        ),
                      )
                    ],
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

class TheForm extends StatelessWidget {
  const TheForm({
    super.key,
    required this.titleController,
    required this.desController,
    required this.userEmailController,
    required this.userPhoneController,
    required this.controller,
    required this.bidingOnController,
  });
  final TextEditingController titleController;
  final TextEditingController desController;
  final TextEditingController userEmailController;
  final TextEditingController userPhoneController;
  final TextEditingController bidingOnController;

  final BidFormController controller;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
          top: Spacing().md, left: Spacing().sm, right: Spacing().sm),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                try {
                  FormModelBottomSheet()
                      .showFormModelBottomSheet(context, controller);
                } catch (e) {
                  ReturnWidgets()
                      .returnBottomSheet(context, "An Error Occurred $e");
                }
              },
              child: Obx(
                () => Container(
                  width: 120,
                  decoration: BoxDecoration(
                      color: AppColors().secSoftGrey,
                      borderRadius: BorderRadius.circular(20)),
                  height: 120,
                  child: controller.image.value == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(UniconsLine.image),
                            Text('Add Image'),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.file(
                            File(controller.image.value!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: TextFieldForForm(
              heading: "Enter Title",
              opacity: 1.0,
              readOnly: false,
              maxLines: 1,
              width: size.width * 0.9,
              height: 120,
              maxLength: 64,
              hintText: "Enter Title",
              controller: titleController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: TextFieldForForm(
              heading: "Biding On",
              opacity: 1.0,
              readOnly: true,
              maxLines: 1,
              width: size.width * 0.9,
              height: 120,
              maxLength: 64,
              hintText: "",
              controller: bidingOnController,
            ),
          ),
          TextFieldForForm(
            heading: "Enter Description",
            opacity: 1.0,
            readOnly: false,
            maxLines: 5,
            width: size.width * 0.9,
            height: 220,
            maxLength: 150,
            hintText: "Enter Description",
            controller: desController,
          ),
          TextFieldForForm(
            heading: "User's Email",
            opacity: 0.5,
            readOnly: true,
            maxLines: 1,
            width: size.width * 0.9,
            height: 120,
            maxLength: 62,
            hintText: "",
            controller: userEmailController,
          ),
          TextFieldForForm(
            heading: "User's Phone Number",
            opacity: 0.5,
            readOnly: true,
            maxLines: 1,
            width: size.width * 0.9,
            height: 120,
            maxLength: 25,
            hintText: "",
            controller: userPhoneController,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Select District",
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.4,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors().primaryBlack),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Get.arguments[TradeFormModel().district],
                            style: context.textTheme.bodySmall,
                          )),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Select Category",
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.4,
                      height: 60,
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors().primaryBlack),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            Get.arguments[TradeFormModel().cat],
                            style: context.textTheme.bodySmall,
                          )),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
