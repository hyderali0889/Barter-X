import 'package:barter_x/Components/main_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    Get.find<EmailController>().startLoading1(true);
    FirebaseAuth.instance.currentUser!.reload();

    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      Get.offAllNamed(Routes().homeScreen);
    }
    Get.find<EmailController>().startLoading1(false);
  }

  @override
  Widget build(BuildContext context) {
    EmailController controller = Get.find<EmailController>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
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
                            Get.find<EmailController>().startLoading2(true);

                            await FirebaseAuth.instance.currentUser!.delete();
                            Get.find<EmailController>().startLoading2(false);

                            Get.offAllNamed(Routes().loginScreen);
                          },
                          mainController: controller.isLoading2.value),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
