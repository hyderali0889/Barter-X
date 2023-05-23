import 'dart:async';

import 'package:barter_x/Components/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/bottom_app_bar.dart';
import '../../Controllers/Auth_Controllers/email_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/main_colors.dart';
import '../../Themes/spacing.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  EmailController controller = Get.find<EmailController>();

  Timer? countdownTimer;

  void resetTimer() {
    stopTimer();

    controller.changeDuration(const Duration(seconds: 30));
  }

  void startTimer() {
    controller.startTimer(true);

    resetTimer();
    countdownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => setCountDown());
  }

  // Step 4
  void stopTimer() {
    if (countdownTimer != null) {
      countdownTimer!.cancel();
    }
  }

  void setCountDown() {
    const reduceSecondsBy = 1;
    controller.startTimer(true);
    final seconds = controller.myDuration.value.inSeconds - reduceSecondsBy;
    if (seconds < 0) {
      countdownTimer!.cancel();
      controller.startTimer(false);
    } else {
      controller.changeDuration(Duration(seconds: seconds));
    }
  }

  void checkEmailVerification() {
    try {
      controller.changeErrorStatus(false);

      controller.startLoading1(true);
      FirebaseAuth.instance.currentUser!.reload();

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Get.offAllNamed(Routes().phoneAuthScreen);
      } else {
        controller.changeErrorStatus(true);
        controller
            .changeErrorMessage("An Error Occurred, Email not Confirmed yet.");
      }
      controller.startLoading1(false);
    } on FirebaseAuthException catch (e) {
      stopTimer();
      controller.startTimer(false);
      controller.startLoading1(false);
      controller.changeErrorStatus(true);
      controller.changeErrorMessage("An Error Occurred, ${e.message}");
    }
  }

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }

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
          Obx(
            () => Opacity(
              opacity: controller.errorOcurred.value ? 0.6 : 1,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Padding(
                  padding: EdgeInsets.all(Spacing().sm),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: size.height * 0.05),
                            child: Text(
                              "Verification Email Sent",
                              style: context.textTheme.bodyLarge,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Spacing().xs),
                            child: Text(
                              "We've sent a Verification Link to your Email Address. Please Verify your Email and click the Proceed Button Below to Continue. Please check your spam before requesting a new Email.",
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Image.asset("assets/icons/A4.png",
                            height: 200, width: 200),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: Spacing().sm),
                        child: Column(
                          children: [
                            SizedBox(
                              width: size.width,
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.only(top: Spacing().md),
                                  child: Obx(
                                    () => InkWell(
                                      onTap: controller.isTimerRunning.value
                                          ? null
                                          : () async {
                                              try {
                                                startTimer();

                                                 await FirebaseAuth
                                                 .instance.currentUser!
                                                   .sendEmailVerification();
                                              } on FirebaseAuthException catch (e) {
                                                 stopTimer();
      controller.startTimer(false);
                                                controller
                                                    .changeErrorStatus(true);
                                                controller.changeErrorMessage(
                                                    "An Error Occurred, ${e.message}");
                                              }
                                            },
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: size.width * 0.8,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color:
                                                controller.isTimerRunning.value
                                                    ? AppColors().secHalfGrey
                                                    : AppColors().primaryBlue,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: controller.isTimerRunning.value
                                            ? Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: Spacing().sm),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      "Resend Email",
                                                      style: context.textTheme
                                                          .displayMedium,
                                                    ),
                                                    Text(
                                                      controller.myDuration.value.inSeconds.remainder(60).toString().padLeft(2, "0"),
                                                      style: context.textTheme
                                                          .displayMedium,
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Text(
                                                "Resend Email",
                                                style: context
                                                    .textTheme.displayMedium,
                                              ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Obx(
                              () => MainButton(
                                  size: size,
                                  buttonText: "Proceed",
                                  actionFunction: () {
                                    checkEmailVerification();
                                  },
                                  mainController: controller.isLoading1.value),
                            ),
                            Obx(
                              () => MainButton(
                                  size: size,
                                  buttonText: "Go Back",
                                  actionFunction: () async {
                                    try {
                                      FocusScope.of(context).unfocus();
                                      controller.errorOcurred(false);

                                      controller.startLoading2(true);

                                      await FirebaseAuth.instance.currentUser!
                                          .delete()
                                          .timeout(const Duration(seconds: 15));
                                      controller.startLoading2(false);

                                      Get.offAllNamed(Routes().loginScreen);
                                    } on FirebaseAuthException catch (e) {

                                      controller.errorOcurred(true);
                                      controller.changeErrorMessage(
                                          "An Error Occurred, ${e.message}");
                                    }
                                  },
                                  mainController: controller.isLoading2.value),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => BottomBar(
              controller: controller,
              size: size,
              errorTitle: "Verification Error",
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
