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

class MainView extends StatefulWidget {
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
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    void registerUser() async {
      widget.controller.changeErrorStatus(false);

      try {
        if (widget.emailController.text.isEmpty ||
            widget.passwordController.text.isEmpty) {
          widget.controller.changeErrorStatus(true);
          widget.controller.startLoading(false);

          widget.controller.changeErrorMessage(
              "An Error Occurred, Email and Password Fields cannot be left blank.");
          return;
        }
        widget.controller.startLoading(true);

        FirebaseAuth authInstance = FirebaseAuth.instance;
        await authInstance
            .createUserWithEmailAndPassword(
                email: widget.emailController.text.trim(),
                password: widget.passwordController.text.trim())
            .timeout(const Duration(seconds: 15));

        if (authInstance.currentUser == null) {
          widget.controller.startLoading(false);
          return;
        }
        await authInstance.currentUser!.sendEmailVerification();
        widget.controller.startLoading(false);

        Get.offAllNamed(Routes().emailVerificationScreen);
      } catch (e) {
        widget.controller.startLoading(false);

        widget.controller.changeErrorStatus(true);
        widget.controller.changeErrorMessage("An Error Occurred, $e");
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: widget.size.height * 0.05),
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
                    padding: EdgeInsets.only(top: widget.size.height * 0.05),
                    child: Image.asset(
                      "assets/icons/A2.png",
                      width: 120,
                      height: 120,
                    ),
                  )
                ],
              ),
              InputField(
                maxLenght: 64,
                size: widget.size,
                isEmailField: true,
                controller: widget.emailController,
                title: "Email Address",
                hintText: "Please Enter Email Address",
                obsecureText: false,
                mainController: widget.controller,
                width: widget.size.width * 0.85,
           
              ),
              Obx(
                () => InputField(
                  maxLenght: 64,
                  size: widget.size,
                  isEmailField: false,
                  controller: widget.passwordController,
                  title: "Password",
                  hintText: "Please Enter your Password",
                  obsecureText: widget.controller.obsecureText.value,
                  mainController: widget.controller,
                  width: widget.size.width * 0.85,
             
                ),
              ),
              Obx(
                () => MainButton(
                  size: widget.size,
                  mainController: widget.controller.isLoading.value,
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
