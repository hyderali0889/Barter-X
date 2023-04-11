import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/bottom_app_bar.dart';
import '../../Components/input_field.dart';
import '../../Components/main_button.dart';
import '../../Controllers/Auth_Controllers/register_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/spacing.dart';
import 'package:unicons/unicons.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    RegisterController controller = RegisterController();

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
              errorTitle: "Register Error",
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
  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    void registerUser() async {
      controller.changeErrorStatus(false);
      FocusScope.of(context).unfocus();

      try {
        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          controller.changeErrorStatus(true);
          controller.startLoading(false);

          controller.changeErrorMessage(
              "An Error Occurred, Email and Password Fields cannot be left blank.");
          return;
        }
        controller.startLoading(true);

        FirebaseAuth authInstance = FirebaseAuth.instance;
        await authInstance
            .createUserWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .timeout(const Duration(seconds: 15));

        if (authInstance.currentUser == null) {
            controller.startLoading(false);
          return;
        }
        await authInstance.currentUser!.sendEmailVerification();
        controller.startLoading(false);

        Get.offAllNamed(Routes().emailVerificationScreen);

      } catch (e) {
        controller.startLoading(false);

        controller.changeErrorStatus(true);
        controller.changeErrorMessage("An Error Occurred, $e");
      }
    }

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
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.05),
                child: Text(
                  "Register Account",
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
              Obx(
                () => InputField(
                  size: size,
                  isEmailField: false,
                  controller: passwordController,
                  title: "Password",
                  hintText: "Please Enter your Password",
                  obsecureText: controller.obsecureText.value,
                  mainController: controller,
                  width: size.width * 0.85,
                  height: 50,
                ),
              ),
              Obx(
                ()=> MainButton(
                  size: size,
                  mainController: controller.isLoading.value,
                  buttonText: "Sign Up",
                  actionFunction: registerUser,
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
