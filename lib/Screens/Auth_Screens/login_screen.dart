import 'package:barter_x/Controllers/Auth_Controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Components/bottom_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    LoginController controller = LoginController();
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          Obx(
            () => Opacity(
              opacity: controller.errorOcurred.value ? 0.6 : 1,
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(controller.errorOcurred.value
                            ? "Hello"
                            : "Byeee"),
                        TextButton(
                            onPressed: () {
                              controller.changeErrorStatus(true);
                            },
                            child: const Text("Change"))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
         BottomBar(controller: controller, size: size),

        ],
      )),
    );
  }
}
