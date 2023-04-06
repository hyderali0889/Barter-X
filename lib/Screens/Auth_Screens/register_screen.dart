import 'package:barter_x/Controllers/Auth_Controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/bottom_app_bar.dart';
import '../../Controllers/Auth_Controllers/register_controller.dart';
import '../../Routes/routes.dart';
import '../../Themes/main_colors.dart';
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
    String networkErrorMsg =
        "We Encountered an error trying to log into your account. Please Check your Network Connection and try again.";

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
          BottomBar(
            controller: controller,
            size: size,
            errorTitle: "Login Error",
            errorMsg: networkErrorMsg,
            closeFunction: closeBottomBar,
            tryAgainFunction: tryAgainBottomBar,
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
                    "Register Account",
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
                  registerController: controller,
                ),
                Obx(
                  () => InputField(
                    size: size,
                    isEmailField: false,
                    controller: passwordController,
                    title: "Password",
                    hintText: "Please Enter your Password",
                    obsecureText: controller.obsecureText.value,
                    registerController: controller,
                  ),
                ),
                MainButton(size: size),
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

class MainButton extends StatelessWidget {
  const MainButton({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Center(
        child: Padding(
          padding: EdgeInsets.only(top: Spacing().lg),
          child: InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                  color: AppColors().primaryBlue,
                  borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Sign Up",
                style: context.textTheme.displayMedium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InputField extends StatelessWidget {
  const InputField({
    super.key,
    required this.size,
    required this.controller,
    required this.title,
    required this.hintText,
    required this.obsecureText,
    required this.registerController,
    required this.isEmailField,
  });

  final Size size;
  final TextEditingController controller;
  final String title;
  final String hintText;
  final bool obsecureText;
  final bool isEmailField;
  final RegisterController registerController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Spacing().lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodySmall!.copyWith(fontFamily: "bold"),
          ),
          Padding(
            padding: EdgeInsets.only(top: Spacing().xs - 5),
            child: SizedBox(
              width: size.width * 0.8,
              height: 50,
              child: TextFormField(
                style: context.textTheme.bodyMedium,
                obscureText: obsecureText,
                controller: controller,
                decoration: InputDecoration(
                    suffixIcon: isEmailField
                        ? null
                        : obsecureText
                            ? IconButton(
                                onPressed: () {
                                  registerController.changeObsecureText(false);
                                },
                                icon: const Icon(UniconsLine.eye))
                            : IconButton(
                                onPressed: () {
                                  registerController.changeObsecureText(true);
                                },
                                icon: const Icon(UniconsLine.eye_slash)),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: context.textTheme.bodySmall,
                    hintText: hintText),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
