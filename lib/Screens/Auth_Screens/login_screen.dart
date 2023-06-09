import 'package:barter_x/Controllers/Auth_Controllers/login_controller.dart';
import 'package:barter_x/Utils/Firebase_Functions/auth_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  LoginController controller = Get.find<LoginController>();

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
        child:
           SizedBox(
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
    return Padding(
      padding: EdgeInsets.all(Spacing().sm),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.1),
                    child: Image.asset(
                      "assets/icons/A1.png",
                      width: 120,
                      height: 120,
                    ),
                  )
                ],
              ),
              InputField(
                maxLenght: 64,
                size: size,
                func:(e){},
                keyboardType: TextInputType.emailAddress,
                isEmailField: true,
                controller: emailController,
                title: "Email Address",
                hintText: "Please Enter Email Address",
                obsecureText: false,
                mainController: controller,
                width: size.width * 0.85,
              ),
              Obx(
                () => InputField(
                  maxLenght: 64,
                  size: size,
                  isEmailField: false,
                  controller: passwordController,
                  func:(e){
                      FirebaseAuthFunctions()
                          .login(emailController, passwordController, context , controller);
                   },
                keyboardType: TextInputType.emailAddress,
                  title: "Password",
                  hintText: "Please Enter your Password",
                  obsecureText: controller.obsecureText.value,
                  mainController: controller,
                  width: size.width * 0.85,
                ),
              ),
              Obx(
()=> MainButton(
                    size: size,
                    mainController: controller.isLoading.value,
                    buttonText: "Sign In",
                    actionFunction: () {
                      FirebaseAuthFunctions()
                          .login(emailController, passwordController, context , controller);
                    }),
              ),

                Align(
                            alignment: Alignment.center,
                            child:Padding(
padding:const EdgeInsets.all(30),

                             child: Text("Customer Support Email: hyderali0889@gmail.com" , style: context.textTheme.bodySmall!.copyWith(fontSize: 10),))
                           )


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
