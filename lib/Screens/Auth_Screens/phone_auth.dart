import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/bottom_app_bar.dart';
import '../../Components/input_field.dart';
import '../../Components/main_button.dart';
import '../../Controllers/Auth_Controllers/phone_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/spacing.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  PhoneController controller = Get.find<PhoneController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void signInWithPhone() async {
      try {
        FocusScope.of(context).unfocus();

        controller.changeErrorStatus(false);
        if (phoneController.text.isEmpty || phoneController.text.length < 10) {
          controller.changeErrorStatus(true);

          controller
              .changeErrorMessage("An Error Occurred, Invalid Phone Number");
          return;
        }
        controller.startLoading(true);

        FirebaseAuth auth = FirebaseAuth.instance;

        await auth.verifyPhoneNumber(
            forceResendingToken: controller.token.value,
            phoneNumber: "+92${phoneController.text.trim()}",
            verificationCompleted: (credential) async {
              await auth.signInWithCredential(credential);
              Get.offAllNamed(Routes().routeCheck);
            },
            verificationFailed: (verificationFailed) {
              controller.startLoading(false);
              controller.changeErrorStatus(true);
              controller.changeErrorMessage(
                  "An Error Occurred, ${verificationFailed.message} Please Try Again");
            },
            codeSent: (verificationToken, forceResendToken) {
              controller.setToken(forceResendToken!);
              controller.setVerID(verificationToken);

              Get.offAllNamed(
                Routes().otpScreen,
                arguments: verificationToken
              );
            },
            codeAutoRetrievalTimeout: (verificationId) {
              controller.startLoading(false);
              controller.changeErrorStatus(true);
              controller.changeErrorMessage(
                  "An Error Occurred, Connection Timed Out. Please Try Again");
            });
      } on FirebaseAuthException catch (e) {
        controller.startLoading(false);
        controller.changeErrorStatus(true);
        controller.changeErrorMessage("An Error Occurred, ${e.message}");
      }
    }

    void closeBottomBar() {
      controller.changeErrorStatus(false);
    }

    void tryAgainBottomBar() {
      controller.changeErrorStatus(false);
    }

    return Scaffold(
        body: Stack(
      children: [
        SafeArea(
          child: Obx(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
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
                                        "Register Yourself",
                                        style: context.textTheme.bodyLarge,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(top: Spacing().xs),
                                      child: Text(
                                        "Register to Barter-X",
                                        style: context.textTheme.bodySmall,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(top: size.height * 0.05),
                                  child: Image.asset(
                                    "assets/icons/A3.png",
                                    width: 120,
                                    height: 120,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: Spacing().sm),
                                  child: SizedBox(
                                    width: size.width * 0.1,
                                    height: 50,
                                    child: TextFormField(
                                      initialValue: "+92",
                                      keyboardType: TextInputType.number,
                                      style: context.textTheme.bodyMedium,
                                      readOnly: true,
                                      decoration: const InputDecoration(
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                ),
                                InputField(
                                  maxLenght: 10,
                                  size: size,
                                  isEmailField: true,
                                  controller: phoneController,
                                  title: "Phone Number",
                                  hintText: "Please Enter Your Phone Number",
                                  obsecureText: false,
                                  mainController: controller,
                                  width: size.width * 0.75,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Spacing().xs),
                              child: Text(
                                "* Pakistan is the only country supported right now. Please remove the first 0 from your phone number before entering.",
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                            MainButton(
                              size: size,
                              mainController: controller.isLoading.value,
                              buttonText: "Send OTP",
                              actionFunction: () {
                                signInWithPhone();
                              },
                            ),
                            MainButton(
                              size: size,
                              mainController: controller.isLoading1.value,
                              buttonText: "Back To Login",
                              actionFunction: () async {
                                try {
                                  FocusScope.of(context).unfocus();
                                  controller.errorOcurred(false);

                                  controller.startLoading1(true);

                                  await FirebaseAuth.instance.currentUser!
                                      .delete()
                                      .timeout(const Duration(seconds: 15));
                                  controller.startLoading1(false);

                                  Get.offAllNamed(Routes().loginScreen);
                                } catch (e) {
                                  controller.startLoading1(false);
                                  controller.errorOcurred(true);
                                  controller.changeErrorMessage(
                                      "An Error Occurred, $e");
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
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
            errorTitle: "Login Error",
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
    ));
  }
}
