import 'package:barter_x/Components/main_button.dart';
import 'package:barter_x/Controllers/Auth_Controllers/phone_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/Auth_Controllers/otp_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/main_colors.dart';
import '../../Themes/spacing.dart';
import '../../Utils/Firebase_Functions/auth_functions.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController1 = TextEditingController();
  TextEditingController otpController2 = TextEditingController();
  TextEditingController otpController3 = TextEditingController();
  TextEditingController otpController4 = TextEditingController();
  TextEditingController otpController5 = TextEditingController();
  TextEditingController otpController6 = TextEditingController();
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();

  OTPController controller = Get.find<OTPController>();
  PhoneController phncontroller = Get.find<PhoneController>();

  @override
  void dispose() {
    otpController1.dispose();
    otpController2.dispose();
    otpController3.dispose();
    otpController4.dispose();
    otpController5.dispose();
    otpController6.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    focusNode4.dispose();
    focusNode5.dispose();
    focusNode6.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String otpController =
        "${otpController1.text.trim()}${otpController2.text.trim()}${otpController3.text.trim()}${otpController4.text.trim()}${otpController5.text.trim()}${otpController6.text.trim()}";

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
              child: Padding(
                padding: EdgeInsets.all(Spacing().sm),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: size.height * 0.05),
                              child: Text(
                                "Verify OTP",
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Spacing().xs),
                              child: Text(
                                "Phone Number Registration",
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.05),
                          child: Image.asset(
                            "assets/icons/A6.png",
                            width: 120,
                            height: 120,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: Spacing().sm),
                                child: Text(
                                  "Enter Your OTP",
                                  style: context.textTheme.bodySmall,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: Spacing().xs),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        InputFieldArea(
                                            controller: otpController1,
                                            func: (e) {},
                                            functionToCall: (String val) {
                                              if (val.length == 1) {
                                                focusNode2.requestFocus();
                                              }
                                            },
                                            focusNode: focusNode1,
                                            size: size),
                                        InputFieldArea(
                                            controller: otpController2,
                                            func: (e) {},
                                            functionToCall: (String val) {
                                              if (val.length == 1) {
                                                focusNode3.requestFocus();
                                              } else {
                                                focusNode1.requestFocus();
                                              }
                                            },
                                            focusNode: focusNode2,
                                            size: size),
                                        InputFieldArea(
                                            controller: otpController3,
                                            func: (e) {},
                                            functionToCall: (String val) {
                                              if (val.length == 1) {
                                                focusNode4.requestFocus();
                                              } else {
                                                focusNode2.requestFocus();
                                              }
                                            },
                                            focusNode: focusNode3,
                                            size: size),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        InputFieldArea(
                                            controller: otpController4,
                                            func: (e) {},
                                            functionToCall: (String val) {
                                              if (val.length == 1) {
                                                focusNode5.requestFocus();
                                              } else {
                                                focusNode3.requestFocus();
                                              }
                                            },
                                            focusNode: focusNode4,
                                            size: size),
                                        InputFieldArea(
                                            controller: otpController5,
                                            func: (e) {},
                                            functionToCall: (String val) {
                                              if (val.length == 1) {
                                                focusNode6.requestFocus();
                                              } else {
                                                focusNode4.requestFocus();
                                              }
                                            },
                                            focusNode: focusNode5,
                                            size: size),
                                        InputFieldArea(
                                            controller: otpController6,
                                            func: (e) {
                                              FirebaseAuthFunctions().checkOTP(
                                                  context,
                                                  otpController,
                                                  controller);
                                            },
                                            functionToCall: (String val) {
                                              if (val.length != 1) {
                                                focusNode5.requestFocus();
                                              }
                                            },
                                            focusNode: focusNode6,
                                            size: size),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Obx(
                                () => MainButton(
                                    size: size,
                                    buttonText: "Proceed",
                                    actionFunction: () {
                                      FirebaseAuthFunctions().checkOTP(
                                          context, otpController, controller);
                                    },
                                    mainController:
                                        controller.isLoading1.value),
                              ),
                              MainButton(
                                  size: size,
                                  buttonText: "Resend Token",
                                  actionFunction: () {
                                    Get.offAllNamed(Routes().phoneAuthScreen);
                                  },
                                  mainController: false),
                              MainButton(
                                size: size,
                                mainController: false,
                                buttonText: "Back To Login",
                                actionFunction: () {
                                  Get.offAllNamed(Routes().loginScreen);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class InputFieldArea extends StatelessWidget {
  const InputFieldArea({
    super.key,
    required this.controller,
    required this.size,
    required this.focusNode,
    required this.functionToCall,
    required this.func,
  });
  final TextEditingController controller;
  final Size size;
  final FocusNode focusNode;
  final Function(String)? functionToCall;
  final Function(String)? func;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: size.width * 0.1,
        height: 75,
        child: TextFormField(
          keyboardType: TextInputType.number,
          onFieldSubmitted: func,
          focusNode: focusNode,
          onChanged: functionToCall,
          maxLength: 1,
          style: context.textTheme.bodyMedium,
          controller: controller,
          decoration: InputDecoration(
            counterText: "",
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors().labelOffBlack)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors().labelOffBlack)),
          ),
        ),
      ),
    );
  }
}
