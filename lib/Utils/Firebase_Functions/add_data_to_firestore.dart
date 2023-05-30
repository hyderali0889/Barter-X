import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Models/trade_form_model.dart';
import '../../Routes/routes.dart';
import '../Generators/random_alpha_generator.dart';
import '../Widgets/show_modal_sheet.dart';

class AddDataToFirestore{

   void addTradeToFirebase(context,path , file , controller , TextEditingController titleController , TextEditingController tradeWithController , TextEditingController desController) async {
    try {
      String randomId = RandomGenerator().generateRandomString(10);
      FirebaseStorage storage = FirebaseStorage.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      if (tradeWithController.text.isEmpty ||
      controller.selectedCat.value == "" ||
          controller.image.value == null ||
          titleController.text.isEmpty ||
          controller.selectedDistrict.value == "" ||
          desController.text.isEmpty) {

      ReturnWidgets().returnBottomSheet(context, "Please Fill all the fields and tryagain");


        return;
      }
      controller.startLoading(true);


      UploadTask fileurl = storage.ref().child(path).putFile(file);

      final snapshot = await fileurl.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();


      firestore
          .collection( "Trade"        )
          .doc(DateTime.now().toString())
          .set({
        TradeFormModel().title: titleController.text.trim(),
        TradeFormModel().tradeWith:
            tradeWithController.text.trim(),
        TradeFormModel().userId: auth.currentUser!.uid,
        TradeFormModel().productId: randomId,
        TradeFormModel().isActive: true,
        TradeFormModel().img: downloadUrl,
        TradeFormModel().des: desController.text.trim(),

        TradeFormModel().email: auth.currentUser!.email,
        TradeFormModel().phone: auth.currentUser!.phoneNumber,
        TradeFormModel().district: controller.selectedDistrict.value,
        TradeFormModel().cat: controller.selectedCat.value
      });
      controller.startLoading(false);
      Get.offAllNamed(Routes().navigationScreen, arguments: 0);
    } on PlatformException catch (e) {
      controller.startLoading(false);

            ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");

    }
  }

void addEWasteToFirebase(context,controller , path ,file , TextEditingController titleController , TextEditingController tradeWithController  , TextEditingController desController) async {
    try {
      String randomId = RandomGenerator().generateRandomString(10);



      FirebaseStorage storage = FirebaseStorage.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;


      if (tradeWithController.text.isEmpty ||
          controller.image.value == null ||
          titleController.text.isEmpty ||
          controller.selectedDistrict.value == "" ||
          desController.text.isEmpty) {
             ReturnWidgets().returnBottomSheet(context,
                   "NO Image Selected or any field is empty. Please fill all the fields and try again.");
        return;
      }
      controller.startLoading(true);


      UploadTask fileurl = storage.ref().child(path).putFile(file);

      final snapshot = await fileurl.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      firestore
          .collection("EWaste")
          .doc(DateTime.now().toString())
          .set({
        TradeFormModel().title: titleController.text.trim(),
        TradeFormModel().tradeWith:
             tradeWithController.text.trim(),
        TradeFormModel().userId: auth.currentUser!.uid,
        TradeFormModel().productId: randomId,
        TradeFormModel().isActive: true,
        TradeFormModel().img: downloadUrl,
        TradeFormModel().des: desController.text.trim(),

        TradeFormModel().email: auth.currentUser!.email,
        TradeFormModel().phone: auth.currentUser!.phoneNumber,
        TradeFormModel().district: controller.selectedDistrict.value,
        TradeFormModel().cat: "E-Waste"

      });
      controller.startLoading(false);
      Get.offAllNamed(Routes().navigationScreen, arguments: 0);
    } on PlatformException catch (e) {
      controller.startLoading(false);

                   ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");

    }
  }

   void addAuctionDataToFirebase(context , controller , path,file , TextEditingController titleController ,TextEditingController desController) async {
    try {
      String randomId = RandomGenerator().generateRandomString(10);

      FirebaseStorage storage = FirebaseStorage.instance;
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      if (controller.selectedCat.value == "" ||
          controller.image.value == null ||
          titleController.text.isEmpty ||
          controller.selectedDistrict.value == "" ||
          desController.text.isEmpty) {
        ReturnWidgets().returnBottomSheet(context,
            "NO Image Selected or any field is empty. Please fill all the fields and try again.");
        return;
      }
      controller.startLoading(true);


      UploadTask fileurl = storage.ref().child(path).putFile(file);

      final snapshot = await fileurl.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();

      DateTime nowDate = DateTime.now();
      firestore.collection("Auction").doc(DateTime.now().toString()).set({
        TradeFormModel().title: titleController.text.trim(),
        TradeFormModel().userId: auth.currentUser!.uid,
        TradeFormModel().productId: randomId,
        TradeFormModel().isActive: true,
        TradeFormModel().img: downloadUrl,
        TradeFormModel().des: desController.text.trim(),
        TradeFormModel().date:
            DateTime(nowDate.year, nowDate.month, nowDate.day + 3),
        TradeFormModel().email: auth.currentUser!.email,
        TradeFormModel().phone: auth.currentUser!.phoneNumber,
        TradeFormModel().district: controller.selectedDistrict.value,
        TradeFormModel().cat: controller.selectedCat.value
      });
      controller.startLoading(false);
      Get.offAllNamed(Routes().navigationScreen, arguments: 0);
    } on PlatformException catch (e) {
      controller.startLoading(false);

      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }



  //End Of Function
 }