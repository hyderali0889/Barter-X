import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/input_field.dart';
import '../../Components/main_button.dart';
import '../../Controllers/Auth_Controllers/phone_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/spacing.dart';
import '../../Utils/Firebase_Functions/auth_functions.dart';

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
  void dispose() {
    phoneController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
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
                              padding: EdgeInsets.only(top: size.height * 0.05),
                              child: Text(
                                "Register Yourself",
                                style: context.textTheme.bodyLarge,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: Spacing().xs),
                              child: Text(
                                "Register to Barter-X",
                                style: context.textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: size.height * 0.05),
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
                          func:(e){
                              FirebaseAuthFunctions().signInWithPhone(
                              context, controller, phoneController);
                           },
                keyboardType: TextInputType.emailAddress,
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
                        "* Pakistan is the only country supported right now. Please remove the first 0 from your phone number before entering. \nThe Function can fail once. Please try again if this happens.",
                        style: context.textTheme.bodySmall,
                      ),
                    ),
                    Obx(
                      () => MainButton(
                        size: size,
                        mainController: controller.isLoading.value,
                        buttonText: "Send OTP",
                        actionFunction: () {
                          FirebaseAuthFunctions().signInWithPhone(
                              context, controller, phoneController);
                        },
                      ),
                    ),

                       MainButton(
                        size: size,
                        mainController: false,
                        buttonText: "Back To Login",
                        actionFunction: () {
                          Get.offAllNamed(Routes().loginScreen);
                        },
                      ),

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
