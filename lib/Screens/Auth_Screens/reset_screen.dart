import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/bottom_app_bar.dart';
import '../../Components/input_field.dart';
import '../../Components/main_button.dart';
import '../../Controllers/Auth_Controllers/reset_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/spacing.dart';
import 'package:unicons/unicons.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ResetController controller = ResetController();

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
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: MainView(
                    size: size,
                    emailController: emailController,
                    passwordController: passwordController,
                    controller: controller),
              ),
            ),
          ),
          Obx(
            () => BottomBar(
              controller: controller,
              size: size,
              errorTitle: "Reset Password Error",
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
      )),
    );
  }
}

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required this.size,
    required this.emailController,
    required this.passwordController,
    required this.controller,
  });

  final Size size;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ResetController controller;

  @override
  Widget build(BuildContext context) {
    void resetPassword() async {
      controller.changeErrorStatus(false);
      FocusScope.of(context).unfocus();
      try {
        if (emailController.text.isEmpty) {
          controller.changeErrorStatus(true);
          controller.changeErrorMessage(
              "An Error Occurred, Email Field cannot be left blank.");
          controller.startLoading(false);

          return;
        }
        controller.startLoading(true);

        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim())
            .timeout(const Duration(seconds: 5));
        controller.startLoading(false);
      } catch (e) {
        controller.changeErrorStatus(true);
        controller.startLoading(false);

        controller.changeErrorMessage("An Error Occurred, $e");
      }
    }

    return InkWell(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
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
                    "Enter your email to reset password.",
                    style: context.textTheme.bodySmall,
                  ),
                ),
                InputField(
                  size: size,
                  isEmailField: true,
                  controller: emailController,
                  title: "Email Address",
                  hintText: "Please Enter Email Address",
                  obsecureText: false,
                  mainController: controller,
                  width: size.width * 0.85,
                  height: 50,
                ),
                MainButton(
                  size: size,
                  mainController: controller,
                  buttonText: "Reset Password",
                  actionFunction: resetPassword,
                ),
              ],
            ),
            const BottomRow()
          ],
        ),
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
