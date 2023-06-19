import 'package:barter_x/Components/form_text_field.dart';
import 'package:barter_x/Components/main_button.dart';
import 'package:barter_x/Components/top_row.dart';
import 'package:barter_x/Controllers/Main_Controllers/Other_Controllers/chnage_password_controller.dart';
import 'package:barter_x/Utils/Widgets/show_modal_sheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Routes/routes.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController prevPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ChangePasswordController controller = Get.find<ChangePasswordController>();
    return Scaffold(
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            const TopRow(text: "Change Password"),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: TextFieldForForm(
                  width: size.width * 0.9,
                  maxLength: 64,
                  controller: prevPassController,
                  hintText: "Enter Previous Password",
                  maxLines: 1,
                  height: 120,
                  readOnly: false,
                  opacity: 1,
                  heading: "Enter Previous Password"),
            ),
            TextFieldForForm(
                width: size.width * 0.9,
                maxLength: 64,
                controller: newPassController,
                hintText: "Enter New Password",
                maxLines: 1,
                height: 120,
                readOnly: false,
                opacity: 1,
                heading: "Enter New Password"),
            Obx(
              () => MainButton(
                  size: size,
                  buttonText: "Change Password",
                  actionFunction: () {
                    try {
                      if (prevPassController.text.isEmpty ||
                          newPassController.text.isEmpty) {
                        ReturnWidgets().returnBottomSheet(
                            context, "An Error Occured Please Enter Password");
                      }
                      controller.startLoading(true);
                      FirebaseAuth.instance.currentUser!
                          .updatePassword(newPassController.text.trim());
                      Get.offAllNamed(Routes().navigationScreen);
                      controller.startLoading(false);
                    } catch (e) {
                      controller.startLoading(false);

                      ReturnWidgets()
                          .returnBottomSheet(context, "An Error Occured $e");
                    }
                  },
                  mainController: controller.isLoading.value),
            )
          ],
        ),
      )),
    );
  }
}
