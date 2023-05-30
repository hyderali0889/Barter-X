import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/input_field.dart';
import '../../Components/main_button.dart';
import '../../Controllers/Auth_Controllers/register_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/spacing.dart';
import 'package:unicons/unicons.dart';

import '../../Utils/Firebase_Functions/auth_functions.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RegisterController controller = Get.find<RegisterController>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
        child: SizedBox(
         width: size.width,
         height: size.height,
         child: MainView(
             size: size,
             emailController: emailController,
             passwordController: passwordController,
             controller: controller),
              ),
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
                    actionFunction: () {
                      FirebaseAuthFunctions().registerUser(
                          context,
                          widget.controller,
                          widget.emailController,
                          widget.passwordController);
                    }),
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
