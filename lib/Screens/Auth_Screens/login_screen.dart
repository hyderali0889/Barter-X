import 'package:barter_x/Controllers/Auth_Controllers/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/bottom_app_bar.dart';
import '../../Components/input_field.dart';
import '../../Components/main_button.dart';
import '../../Routes/routes.dart';
import '../../Themes/spacing.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginController controller = LoginController();

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
  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    void login() async {
      controller.changeErrorStatus(false);
      FocusScope.of(context).unfocus();

      try {
        if (emailController.text.isEmpty || passwordController.text.isEmpty) {
          controller.changeErrorStatus(true);
          controller.changeErrorMessage(
              "An Error Occurred, Email and Password Fields cannot be left blank.");
          return;
        }
        controller.startLoading(true);
        FirebaseAuth authInstance = FirebaseAuth.instance;

        await authInstance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .timeout(const Duration(seconds: 15));
        controller.startLoading(false);

        Get.offAllNamed(Routes().homeScreen);
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
              Padding(
                padding: EdgeInsets.only(top: size.height * 0.1),
                child: Text(
                  "Welcome Back to\nBarter-X",
                  style: context.textTheme.bodyLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Spacing().xs),
                child: Text(
                  "Your Own Barter Trade App.",
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
               () =>MainButton(
                  size: size,
                  mainController: controller.isLoading.value,
                  buttonText: "Sign In",
                  actionFunction: login,
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextButton(
            onPressed: () {
               Get.toNamed(Routes().resetScreen);
            },
            child: Text(
              "Forgot Password",
              style: context.textTheme.bodySmall,
            )),
        TextButton(
            onPressed: () {
              Get.toNamed(Routes().registerScreen);
            },
            child: Text(
              "Sign Up",
              style: context.textTheme.bodySmall,
            ))
      ],
    );
  }
}
