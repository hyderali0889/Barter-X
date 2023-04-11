import 'package:barter_x/Routes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAllNamed(Routes().loginScreen);
                },
                child: const Text("Sign oUt"))
          ],
        ),
      )),
    );
  }
}
