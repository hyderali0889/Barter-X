import 'package:barter_x/Components/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/bottom_app_bar.dart';
import '../../Controllers/Auth_Controllers/email_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/spacing.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  @override
  void initState() {
    super.initState();
    checkEmailVerification();
  }

  void checkEmailVerification() {
    try {
      Get.find<EmailController>().changeErrorStatus(false);

      Get.find<EmailController>().startLoading1(true);
      FirebaseAuth.instance.currentUser!.reload();

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Get.offAllNamed(Routes().phoneAuthScreen);
      } else {
        Get.find<EmailController>().changeErrorStatus(true);
        Get.find<EmailController>()
            .changeErrorMessage("An Error Occurred, Email not Confirmed yet.");
      }
      Get.find<EmailController>().startLoading1(false);
    } catch (e) {
      Get.find<EmailController>().changeErrorStatus(true);
      Get.find<EmailController>().changeErrorMessage("An Error Occurred, $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    EmailController controller = Get.find<EmailController>();

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
                            padding: EdgeInsets.only(top: size.height * 0.1),
                            child: Text(
                              "Verification Email Sent",
                              style: context.textTheme.bodyLarge,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: Spacing().xs),
                            child: Text(
                              "We've sent a Verification Link to your Email Address. Please Verify your Email and click the verify Button Below to Proceed.",
                              style: context.textTheme.bodySmall,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: Spacing().sm),
                        child: Column(
                          children: [
                            Obx(
                              () => MainButton(
                                  size: size,
                                  buttonText: "Verified my Account",
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
                                      controller.errorOcurred(false);

                                      Get.find<EmailController>()
                                          .startLoading2(true);

                                      await FirebaseAuth.instance.currentUser!
                                          .delete()
                                          .timeout(const Duration(seconds: 15));
                                      Get.find<EmailController>()
                                          .startLoading2(false);

                                      Get.offAllNamed(Routes().loginScreen);
                                    } catch (e) {
                                      controller.errorOcurred(true);
                                      controller.changeErrorMessage(
                                          "An Error Occurred, $e");
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
              errorTitle: "Network Connection Error",
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
