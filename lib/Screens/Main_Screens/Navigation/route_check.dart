// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../Routes/routes.dart';
import '../../../Themes/spacing.dart';
import '../../../Utils/Firebase_Functions/firebase_function.dart';


class RouteCheck extends StatefulWidget {
  const RouteCheck({super.key});

  @override
  State<RouteCheck> createState() => _RouteCheckState();
}

class _RouteCheckState extends State<RouteCheck> {

  @override
  void initState() {
    super.initState();
    checkUserRoute();
  }

  checkUserRoute() async {
    try {
      await FirebaseAuth.instance.currentUser!.reload();
        DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFunctions()
          .getActiveTrades(context, FirebaseAuth.instance.currentUser!.uid);

      if (!FirebaseAuth.instance.currentUser!.emailVerified) {
        Get.offAllNamed(Routes().emailVerificationScreen);
      } else if (FirebaseAuth.instance.currentUser!.phoneNumber == null) {
        Get.offAllNamed(Routes().phoneAuthScreen);
      } else if (data.data()!["ActiveTradeCat"] !=null) {
        Get.offAllNamed(Routes().confirmationScreen);
      } else {
        Get.offAllNamed(Routes().navigationScreen);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message);
      Get.offAllNamed(Routes().loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Spacing().sm),
        child: SafeArea(
            child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
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
                        padding: EdgeInsets.only(top: size.height * 0.05),
                        child: Text(
                          "Route Check",
                          style: context.textTheme.bodyLarge,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Spacing().xs),
                        child: Text(
                          "Finding Your Route",
                          style: context.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: size.height * 0.1),
                    child: Image.asset(
                      "assets/icons/A7.png",
                      width: 120,
                      height: 120,
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Lottie.asset("assets/jsons/wifi-router.json",
                      height: 300, width: 300),
                  Padding(
                    padding: EdgeInsets.only(top: Spacing().sm),
                    child: Text(
                      "Looking for your specific route. Please give us a moment",
                      style: context.textTheme.bodyMedium,
                    ),
                  )
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
