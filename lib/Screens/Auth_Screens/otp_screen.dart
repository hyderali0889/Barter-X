import 'package:barter_x/Components/main_button.dart';
import 'package:barter_x/Controllers/Auth_Controllers/phone_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/bottom_app_bar.dart';
import '../../Controllers/Auth_Controllers/otp_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/main_colors.dart';
import '../../Themes/spacing.dart';

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

    void checkOTP() async {
      try {
        if (otpController.trim().length < 6) {
          controller.changeErrorStatus(true);
          controller.changeErrorMessage("An Error Occurred, Invalid OTP");
          return;
        }
        FocusScope.of(context).unfocus();
        controller.startLoading1(true);
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: Get.arguments, smsCode: otpController.trim());

        await FirebaseAuth.instance.currentUser!.linkWithCredential(credential);
        controller.startLoading1(false);

        await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .set({
          "userId": FirebaseAuth.instance.currentUser!.uid.toString(),
          "Points": 0,
          "Ratings" : 0
        });

        Get.offAllNamed(Routes().routeCheck);
      } on FirebaseAuthException catch (e) {
        controller.startLoading1(false);

        controller.changeErrorStatus(true);

        controller.changeErrorMessage(
            "An Error Occurred, ${e.message}. Please Try Again");
      }
    }

    void closeBottomBar() {
      controller.changeErrorStatus(false);
    }

    void tryAgainBottomBar() {
      controller.changeErrorStatus(false);
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Obx(
                () => Opacity(
                  opacity: controller.errorOcurred.value ? 0.6 : 1,
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
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.05),
                                      child: Text(
                                        "Verify OTP",
                                        style: context.textTheme.bodyLarge,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: Spacing().xs),
                                      child: Text(
                                        "Phone Number Registration",
                                        style: context.textTheme.bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.05),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: Spacing().sm),
                                        child: Text(
                                          "Enter Your OTP",
                                          style: context.textTheme.bodySmall,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.only(top: Spacing().xs),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                InputFieldArea(
                                                    controller: otpController1,
                                                    functionToCall:
                                                        (String val) {
                                                      if (val.length == 1) {
                                                        focusNode2
                                                            .requestFocus();
                                                      }
                                                    },
                                                    focusNode: focusNode1,
                                                    size: size),
                                                InputFieldArea(
                                                    controller: otpController2,
                                                    functionToCall:
                                                        (String val) {
                                                      if (val.length == 1) {
                                                        focusNode3
                                                            .requestFocus();
                                                      } else {
                                                        focusNode1
                                                            .requestFocus();
                                                      }
                                                    },
                                                    focusNode: focusNode2,
                                                    size: size),
                                                InputFieldArea(
                                                    controller: otpController3,
                                                    functionToCall:
                                                        (String val) {
                                                      if (val.length == 1) {
                                                        focusNode4
                                                            .requestFocus();
                                                      } else {
                                                        focusNode2
                                                            .requestFocus();
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
                                                    functionToCall:
                                                        (String val) {
                                                      if (val.length == 1) {
                                                        focusNode5
                                                            .requestFocus();
                                                      } else {
                                                        focusNode3
                                                            .requestFocus();
                                                      }
                                                    },
                                                    focusNode: focusNode4,
                                                    size: size),
                                                InputFieldArea(
                                                    controller: otpController5,
                                                    functionToCall:
                                                        (String val) {
                                                      if (val.length == 1) {
                                                        focusNode6
                                                            .requestFocus();
                                                      } else {
                                                        focusNode4
                                                            .requestFocus();
                                                      }
                                                    },
                                                    focusNode: focusNode5,
                                                    size: size),
                                                InputFieldArea(
                                                    controller: otpController6,
                                                    functionToCall:
                                                        (String val) {
                                                      if (val.length != 1) {
                                                        focusNode5
                                                            .requestFocus();
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
                                      MainButton(
                                          size: size,
                                          buttonText: "Proceed",
                                          actionFunction: () {
                                            checkOTP();
                                          },
                                          mainController:
                                              controller.isLoading1.value),
                                      MainButton(
                                          size: size,
                                          buttonText: "Resend Token",
                                          actionFunction: () {
                                            Get.offAllNamed(
                                                Routes().phoneAuthScreen);
                                          },
                                          mainController: false),
                                      MainButton(
                                          size: size,
                                          buttonText: "Back To Login",
                                          actionFunction: () async {
                                            try {
                                              FocusScope.of(context).unfocus();
                                              controller.errorOcurred(false);

                                              controller.startLoading2(true);

                                              await FirebaseAuth
                                                  .instance.currentUser!
                                                  .delete()
                                                  .timeout(const Duration(
                                                      seconds: 15));
                                              controller.startLoading2(false);

                                              Get.offAllNamed(
                                                  Routes().loginScreen);
                                            } catch (e) {
                                              controller.startLoading2(false);
                                              controller.errorOcurred(true);
                                              controller.changeErrorMessage(
                                                  "An Error Occurred, $e");
                                            }
                                          },
                                          mainController:
                                              controller.isLoading2.value),
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
                ),
              ),
              Obx(
                () => BottomBar(
                  controller: controller,
                  size: size,
                  errorTitle: "OTP Error",
                  errorMsg: controller.errorMsg.value,
                  closeFunction: closeBottomBar,
                  tryAgainFunction: tryAgainBottomBar,
                  buttonWidget: Text(
                    "Try Again",
                    style: context.textTheme.displayMedium,
                  ),
                ),
              ),
            ],
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
  });
  final TextEditingController controller;
  final Size size;
  final FocusNode focusNode;
  final Function(String)? functionToCall;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: SizedBox(
        width: size.width * 0.1,
        height: 75,
        child: TextFormField(
          keyboardType: TextInputType.number,
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
