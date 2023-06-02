import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/input_field.dart';
import '../../Components/main_button.dart';
import '../../Controllers/Auth_Controllers/reset_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/spacing.dart';
import 'package:unicons/unicons.dart';

import '../../Utils/Firebase_Functions/auth_functions.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController emailController = TextEditingController();
  ResetController controller = Get.find<ResetController>();

  @override
  void dispose() {
    emailController.dispose();
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
        child:
           SizedBox(
            width: size.width,
            height: size.height,
            child: MainView(
              size: size,
              emailController: emailController,
              controller: controller,
            ),
          ),

      )),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required this.size,
    required this.emailController,
    required this.controller,
  });

  final Size size;
  final TextEditingController emailController;
  final ResetController controller;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.all(Spacing().sm),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(UniconsLine.angle_left),
              ),
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
                          "Reset Password",
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Spacing().xs),
                        child: Text(
                          "Enter your email\nto reset password.",
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
                  )
                ],
              ),
              InputField(
                maxLenght: 64,
                size: size,
                isEmailField: true,
                controller: emailController,
                title: "Email Address",
                hintText: "Please Enter Email Address",
                obsecureText: false,
                   func:(e){
                    FirebaseAuthFunctions().resetPassword(context,controller,emailController);

                           },
                keyboardType: TextInputType.emailAddress,
                mainController: controller,
                width: size.width * 0.85,
              ),
              Obx(
                () => MainButton(
                  size: size,
                  mainController: controller.isLoading.value,
                  buttonText: "Reset Password",
                  actionFunction: () {
                    FirebaseAuthFunctions().resetPassword(context,controller,emailController);
                  },
                ),
              ),
            ],
          ),
          const BottomRow()
        ],
      ),
    );
  }
}

class BottomRow extends StatelessWidget {
  const BottomRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already Have An Account ?",
          style: context.textTheme.bodySmall,
        ),
        TextButton(
            onPressed: () {
              Get.offAllNamed(Routes().loginScreen);
            },
            child: Text(
              "Sign In",
              style: context.textTheme.bodySmall,
            ))
      ],
    );
  }
}
