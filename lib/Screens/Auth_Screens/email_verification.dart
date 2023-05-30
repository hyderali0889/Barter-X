import 'dart:async';

import 'package:barter_x/Components/main_button.dart';
import 'package:barter_x/Utils/Firebase_Functions/auth_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controllers/Auth_Controllers/email_controller.dart';
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

  void checkEmailVerification() {}

  @override
  void dispose() {
    super.dispose();
    stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child:
      SizedBox(
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
                                    : () {
                                        FirebaseAuthFunctions().runTimer(
                                            context,
                                            controller,
                                            startTimer,
                                            stopTimer);
                                      },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: size.width * 0.8,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: controller.isTimerRunning.value
                                          ? AppColors().secHalfGrey
                                          : AppColors().primaryBlue,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: controller.isTimerRunning.value
                                      ? Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: Spacing().sm),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Resend Email",
                                                style: context
                                                    .textTheme.displayMedium,
                                              ),
                                              Text(
                                                controller
                                                    .myDuration.value.inSeconds
                                                    .remainder(60)
                                                    .toString()
                                                    .padLeft(2, "0"),
                                                style: context
                                                    .textTheme.displayMedium,
                                              ),
                                            ],
                                          ),
                                        )
                                      : Text(
                                          "Resend Email",
                                          style:
                                              context.textTheme.displayMedium,
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
                              FirebaseAuthFunctions().sendEmailVerification(
                                  context, controller, stopTimer);
                            },
                            mainController: controller.isLoading1.value),
                      ),
                      Obx(
                        () => MainButton(
                            size: size,
                            buttonText: "Go Back",
                            actionFunction: () async {
                              FirebaseAuthFunctions()
                                  .goBackandDeleteUser(context, controller);
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
    );
  }
}
