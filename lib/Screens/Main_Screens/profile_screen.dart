import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unicons/unicons.dart';

import '../../Components/top_row_no_back.dart';
import '../../Controllers/Main_Controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  
  ProfileController controller = Get.find<ProfileController>();

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
            TopRowNoBack(
              text: "Profile",
              icon: UniconsLine.shopping_cart_alt,
              firstFunc: () {},
            ),
          ],
        ),
      )),
    );
  }
}
