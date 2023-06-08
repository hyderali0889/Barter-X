import 'package:barter_x/Utils/Widgets/show_modal_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/Auth_Controllers/login_controller.dart';
import '../../Routes/routes.dart';

class FirebaseAuthFunctions {
  void login(
      TextEditingController emailController,
      TextEditingController passwordController,
      context,
      LoginController controller) async {
    try {
      FocusScope.of(context).unfocus();
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        ReturnWidgets()
            .returnBottomSheet(context, "Please Enter Email or Password");

        return;
      }

      controller.startLoading(true);
      FirebaseAuth authInstance = FirebaseAuth.instance;

      await authInstance
          .signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .timeout(const Duration(seconds: 30));

      if (FirebaseAuth.instance.currentUser!.phoneNumber == null) {
        await FirebaseAuth.instance.currentUser!.delete();
        controller.startLoading(false);

        ReturnWidgets().returnBottomSheet(context,
            "An Error Occurred. User's Phone Number not found Please register again with phone number.");
        return;
      }

      Get.offAllNamed(Routes().routeCheck);
    } on FirebaseAuthException catch (e) {
      controller.startLoading(false);

      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  void sendEmailVerification(context, controller, stopTimer) {
    try {
      controller.startLoading1(true);
      FirebaseAuth.instance.currentUser!.reload();

      if (FirebaseAuth.instance.currentUser!.emailVerified) {
        Get.offAllNamed(Routes().phoneAuthScreen);
      } else {
        ReturnWidgets().returnBottomSheet(context, "Email Not Confirmed Yet");
      }
      controller.startLoading1(false);
    } on FirebaseAuthException catch (e) {
      stopTimer();
      controller.startTimer(false);
      controller.startLoading1(false);
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  void runTimer(context, controller, startTimer, stopTimer) async {
    try {
      startTimer();

      await FirebaseAuth.instance.currentUser!.sendEmailVerification().timeout(const Duration(seconds: 30));
    } on FirebaseAuthException catch (e) {
      stopTimer();
      controller.startTimer(false);
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  void goBackandDeleteUser(context, controller) async {
    try {
      FocusScope.of(context).unfocus();

      controller.startLoading2(true);

      await FirebaseAuth.instance.currentUser!
          .delete()
          .timeout(const Duration(seconds: 30));
      controller.startLoading2(false);

      Get.offAllNamed(Routes().loginScreen);
    } on FirebaseAuthException catch (e) {
      controller.startLoading2(false);

      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  void checkOTP(context, String otpController, controller) async {
    try {
      if (otpController.trim().length < 6) {
        ReturnWidgets().returnBottomSheet(context, "Invalid OTP");

        return;
      }
      FocusScope.of(context).unfocus();
      controller.startLoading1(true);
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: Get.arguments, smsCode: otpController.trim());

      await FirebaseAuth.instance.currentUser!.linkWithCredential(credential);
      controller.startLoading1(false);
      Get.offAllNamed(Routes().routeCheck);

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "userId": FirebaseAuth.instance.currentUser!.uid.toString(),
        "Points": 0,
        "Ratings": 0
      }).timeout(const Duration(seconds: 30));
    } on FirebaseAuthException catch (e) {
      controller.startLoading1(false);

      Get.offAllNamed(Routes().routeCheck);

      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  void signInWithPhone(
      context, controller, TextEditingController phoneController) async {
    try {
      FocusScope.of(context).unfocus();

      if (phoneController.text.isEmpty || phoneController.text.length < 10) {
        ReturnWidgets()
            .returnBottomSheet(context, "Please Enter Valid Phone Number");

        return;
      }
      controller.startLoading(true);

      FirebaseAuth auth = FirebaseAuth.instance;

      await auth.verifyPhoneNumber(
          forceResendingToken: controller.token.value,
          phoneNumber: "+92${phoneController.text.trim()}",
          verificationCompleted: (credential) async {
            await auth.signInWithCredential(credential);
            Get.offAllNamed(Routes().routeCheck);
          },
          verificationFailed: (verificationFailed) {
            controller.startLoading(false);
            ReturnWidgets().returnBottomSheet(
                context, "${verificationFailed.message} Please Try Again");
          },
          codeSent: (verificationToken, forceResendToken) {
            controller.setToken(forceResendToken!);
            controller.setVerID(verificationToken);

            Get.offAllNamed(Routes().otpScreen, arguments: verificationToken);
          },
          codeAutoRetrievalTimeout: (verificationId) {
            controller.startLoading(false);
          });
    } on FirebaseAuthException catch (e) {
      controller.startLoading(false);
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  void registerUser(context, controller, TextEditingController emailController,
      TextEditingController passwordController) async {
    FocusScope.of(context).unfocus();

    try {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        controller.startLoading(false);

        ReturnWidgets()
            .returnBottomSheet(context, "Please Enter Email and Password");

        return;
      }
      controller.startLoading(true);

      FirebaseAuth authInstance = FirebaseAuth.instance;
      await authInstance
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim())
          .timeout(const Duration(seconds: 30));

      if (authInstance.currentUser == null) {
        controller.startLoading(false);
        return;
      }
      await authInstance.currentUser!.sendEmailVerification().timeout(const Duration(seconds: 30));
      controller.startLoading(false);

      Get.offAllNamed(Routes().emailVerificationScreen);
    } on FirebaseAuthException catch (e) {
      controller.startLoading(false);

      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  void resetPassword(
      context, controller, TextEditingController emailController) async {
    try {
      FocusScope.of(context).unfocus();

      controller.startLoading(false);

      if (emailController.text.isEmpty) {
        ReturnWidgets()
            .returnBottomSheet(context, "Please Enter Email Address");

        controller.startLoading(false);

        return;
      }

      controller.startLoading(true);

      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim())
          .timeout(const Duration(seconds: 30));

      controller.startLoading(false);
    } on FirebaseAuthException catch (e) {
      controller.startLoading(false);

      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }


  // End of Function
}
