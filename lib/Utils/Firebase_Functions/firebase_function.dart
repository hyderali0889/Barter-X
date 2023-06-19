import 'package:barter_x/Controllers/Main_Controllers/Route_Controllers/home_controller.dart';
import 'package:barter_x/Models/trade_form_model.dart';
import 'package:barter_x/Utils/Widgets/show_modal_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../Controllers/Main_Controllers/Auction_SubPages/auction_category_details_controller.dart';
import '../../Controllers/Main_Controllers/Route_Controllers/auction_controller.dart';
import '../../Controllers/Main_Controllers/Route_Controllers/notification_controller.dart';
import '../../Controllers/Main_Controllers/Trade_and_EWaste_SubPages/category_details_controller.dart';
import '../../Controllers/Main_Controllers/Route_Controllers/ewaste_controller.dart';
import '../../Controllers/Main_Controllers/Trade_and_EWaste_SubPages/confimation_controller.dart';

class FirebaseFunctions {
  /*
   ██████╗ ███████╗████████╗    ████████╗██████╗  █████╗ ██████╗ ███████╗    ██████╗  █████╗ ████████╗ █████╗
  ██╔════╝ ██╔════╝╚══██╔══╝    ╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
  ██║  ███╗█████╗     ██║          ██║   ██████╔╝███████║██║  ██║█████╗      ██║  ██║███████║   ██║   ███████║
  ██║   ██║██╔══╝     ██║          ██║   ██╔══██╗██╔══██║██║  ██║██╔══╝      ██║  ██║██╔══██║   ██║   ██╔══██║
  ╚██████╔╝███████╗   ██║          ██║   ██║  ██║██║  ██║██████╔╝███████╗    ██████╔╝██║  ██║   ██║   ██║  ██║
   ╚═════╝ ╚══════╝   ╚═╝          ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝

  */
  void getFirebaseTradeData(context, HomeController controller) {
    try {
      controller.refreshData(true);
      Future<QuerySnapshot<Map<String, dynamic>>> data =
          FirebaseFirestore.instance.collection("Trade").get();

      controller.addTradeData(data);
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
   ██████╗ ███████╗████████╗    ████████╗██████╗  █████╗ ██████╗ ███████╗    ██████╗  █████╗ ████████╗ █████╗     ██████╗ ██╗   ██╗     ██████╗ █████╗ ████████╗███████╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗
  ██╔════╝ ██╔════╝╚══██╔══╝    ╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗    ██╔══██╗╚██╗ ██╔╝    ██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔════╝ ██╔═══██╗██╔══██╗╚██╗ ██╔╝
  ██║  ███╗█████╗     ██║          ██║   ██████╔╝███████║██║  ██║█████╗      ██║  ██║███████║   ██║   ███████║    ██████╔╝ ╚████╔╝     ██║     ███████║   ██║   █████╗  ██║  ███╗██║   ██║██████╔╝ ╚████╔╝
  ██║   ██║██╔══╝     ██║          ██║   ██╔══██╗██╔══██║██║  ██║██╔══╝      ██║  ██║██╔══██║   ██║   ██╔══██║    ██╔══██╗  ╚██╔╝      ██║     ██╔══██║   ██║   ██╔══╝  ██║   ██║██║   ██║██╔══██╗  ╚██╔╝
  ╚██████╔╝███████╗   ██║          ██║   ██║  ██║██║  ██║██████╔╝███████╗    ██████╔╝██║  ██║   ██║   ██║  ██║    ██████╔╝   ██║       ╚██████╗██║  ██║   ██║   ███████╗╚██████╔╝╚██████╔╝██║  ██║   ██║
   ╚═════╝ ╚══════╝   ╚═╝          ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝    ╚═════╝    ╚═╝        ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝   ╚═╝

  */

  void getFirebaseTradeDatabyCategory(
      context, CategoryDetailsController controller, String category) {
    try {
      controller.refreshData(true);
      Future<QuerySnapshot<Map<String, dynamic>>> data = FirebaseFirestore
          .instance
          .collection("Trade")
          .where(TradeFormModel().cat, isEqualTo: category)
          .get();

      controller.addTradeData(data);
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
   ██████╗ ███████╗████████╗    ███████╗██╗    ██╗ █████╗ ███████╗████████╗███████╗    ██████╗  █████╗ ████████╗ █████╗
  ██╔════╝ ██╔════╝╚══██╔══╝    ██╔════╝██║    ██║██╔══██╗██╔════╝╚══██╔══╝██╔════╝    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
  ██║  ███╗█████╗     ██║       █████╗  ██║ █╗ ██║███████║███████╗   ██║   █████╗      ██║  ██║███████║   ██║   ███████║
  ██║   ██║██╔══╝     ██║       ██╔══╝  ██║███╗██║██╔══██║╚════██║   ██║   ██╔══╝      ██║  ██║██╔══██║   ██║   ██╔══██║
  ╚██████╔╝███████╗   ██║       ███████╗╚███╔███╔╝██║  ██║███████║   ██║   ███████╗    ██████╔╝██║  ██║   ██║   ██║  ██║
   ╚═════╝ ╚══════╝   ╚═╝       ╚══════╝ ╚══╝╚══╝ ╚═╝  ╚═╝╚══════╝   ╚═╝   ╚══════╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝

  */

  void getFirebaseEWasteData(context, EWasteController controller) {
    try {
      controller.refreshData(true);
      Future<QuerySnapshot<Map<String, dynamic>>> data =
          FirebaseFirestore.instance.collection("EWaste").get();

      controller.addTradeData(data);
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
   ██████╗ ███████╗████████╗     █████╗ ██╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗    ██████╗  █████╗ ████████╗ █████╗
  ██╔════╝ ██╔════╝╚══██╔══╝    ██╔══██╗██║   ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗
  ██║  ███╗█████╗     ██║       ███████║██║   ██║██║        ██║   ██║██║   ██║██╔██╗ ██║    ██║  ██║███████║   ██║   ███████║
  ██║   ██║██╔══╝     ██║       ██╔══██║██║   ██║██║        ██║   ██║██║   ██║██║╚██╗██║    ██║  ██║██╔══██║   ██║   ██╔══██║
  ╚██████╔╝███████╗   ██║       ██║  ██║╚██████╔╝╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║    ██████╔╝██║  ██║   ██║   ██║  ██║
   ╚═════╝ ╚══════╝   ╚═╝       ╚═╝  ╚═╝ ╚═════╝  ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝

  */

  void getFirebaseAuctionData(context, AuctionController controller) {
    try {
      controller.refreshData(true);
      Future<QuerySnapshot<Map<String, dynamic>>> data =
          FirebaseFirestore.instance.collection("Auction").get();

      controller.addTradeData(data);
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
   ██████╗ ███████╗████████╗     █████╗ ██╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗    ██████╗ ██╗   ██╗     ██████╗ █████╗ ████████╗███████╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗
  ██╔════╝ ██╔════╝╚══██╔══╝    ██╔══██╗██║   ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║    ██╔══██╗╚██╗ ██╔╝    ██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔════╝ ██╔═══██╗██╔══██╗╚██╗ ██╔╝
  ██║  ███╗█████╗     ██║       ███████║██║   ██║██║        ██║   ██║██║   ██║██╔██╗ ██║    ██████╔╝ ╚████╔╝     ██║     ███████║   ██║   █████╗  ██║  ███╗██║   ██║██████╔╝ ╚████╔╝
  ██║   ██║██╔══╝     ██║       ██╔══██║██║   ██║██║        ██║   ██║██║   ██║██║╚██╗██║    ██╔══██╗  ╚██╔╝      ██║     ██╔══██║   ██║   ██╔══╝  ██║   ██║██║   ██║██╔══██╗  ╚██╔╝
  ╚██████╔╝███████╗   ██║       ██║  ██║╚██████╔╝╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║    ██████╔╝   ██║       ╚██████╗██║  ██║   ██║   ███████╗╚██████╔╝╚██████╔╝██║  ██║   ██║
   ╚═════╝ ╚══════╝   ╚═╝       ╚═╝  ╚═╝ ╚═════╝  ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝    ╚═════╝    ╚═╝        ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝   ╚═╝

  */

  void getFirebaseAuctionDatabyCategory(
      context, AuctionCategoryDetailsController controller, String category) {
    try {
      controller.refreshData(true);
      Future<QuerySnapshot<Map<String, dynamic>>> data = FirebaseFirestore
          .instance
          .collection("Auction")
          .where(TradeFormModel().cat, isEqualTo: category)
          .get();

      controller.addTradeData(data);
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
   ██████╗ ███████╗████████╗    ██╗   ██╗███████╗███████╗██████╗     ██████╗  ██████╗ ██╗███╗   ██╗████████╗███████╗
  ██╔════╝ ██╔════╝╚══██╔══╝    ██║   ██║██╔════╝██╔════╝██╔══██╗    ██╔══██╗██╔═══██╗██║████╗  ██║╚══██╔══╝██╔════╝
  ██║  ███╗█████╗     ██║       ██║   ██║███████╗█████╗  ██████╔╝    ██████╔╝██║   ██║██║██╔██╗ ██║   ██║   ███████╗
  ██║   ██║██╔══╝     ██║       ██║   ██║╚════██║██╔══╝  ██╔══██╗    ██╔═══╝ ██║   ██║██║██║╚██╗██║   ██║   ╚════██║
  ╚██████╔╝███████╗   ██║       ╚██████╔╝███████║███████╗██║  ██║    ██║     ╚██████╔╝██║██║ ╚████║   ██║   ███████║
   ╚═════╝ ╚══════╝   ╚═╝        ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝    ╚═╝      ╚═════╝ ╚═╝╚═╝  ╚═══╝   ╚═╝   ╚══════╝

  */

  getUserPoints(context, dynamic controller, userID) async {
    try {
      controller.setUserPoints("");

      DocumentSnapshot<Map<String, dynamic>> points = await FirebaseFirestore
          .instance
          .collection("Users")
          .doc(userID)
          .get();
      controller.setUserPoints(points["Points"].toString());
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
      ██████╗ ███████╗████████╗     █████╗     ███████╗██╗███╗   ██╗ ██████╗ ██╗     ███████╗    ██████╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗ ██████╗████████╗
     ██╔════╝ ██╔════╝╚══██╔══╝    ██╔══██╗    ██╔════╝██║████╗  ██║██╔════╝ ██║     ██╔════╝    ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██║   ██║██╔════╝╚══██╔══╝
     ██║  ███╗█████╗     ██║       ███████║    ███████╗██║██╔██╗ ██║██║  ███╗██║     █████╗      ██████╔╝██████╔╝██║   ██║██║  ██║██║   ██║██║        ██║
     ██║   ██║██╔══╝     ██║       ██╔══██║    ╚════██║██║██║╚██╗██║██║   ██║██║     ██╔══╝      ██╔═══╝ ██╔══██╗██║   ██║██║  ██║██║   ██║██║        ██║
     ╚██████╔╝███████╗   ██║       ██║  ██║    ███████║██║██║ ╚████║╚██████╔╝███████╗███████╗    ██║     ██║  ██║╚██████╔╝██████╔╝╚██████╔╝╚██████╗   ██║
      ╚═════╝ ╚══════╝   ╚═╝       ╚═╝  ╚═╝    ╚══════╝╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝╚══════╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝  ╚═════╝  ╚═════╝   ╚═╝

 */

  getSingleProduct(
      context, productCat, productId, ConfirmationController controller) async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection(productCat)
          .where(TradeFormModel().productId, isEqualTo: productId)
          .get();

      controller.addData(data);
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
  ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗    ██╗   ██╗███████╗███████╗██████╗     ██████╗  █████╗ ████████╗██╗███╗   ██╗ ██████╗ ███████╗
  ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝    ██║   ██║██╔════╝██╔════╝██╔══██╗    ██╔══██╗██╔══██╗╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
  ██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗      ██║   ██║███████╗█████╗  ██████╔╝    ██████╔╝███████║   ██║   ██║██╔██╗ ██║██║  ███╗███████╗
  ██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝      ██║   ██║╚════██║██╔══╝  ██╔══██╗    ██╔══██╗██╔══██║   ██║   ██║██║╚██╗██║██║   ██║╚════██║
  ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗    ╚██████╔╝███████║███████╗██║  ██║    ██║  ██║██║  ██║   ██║   ██║██║ ╚████║╚██████╔╝███████║
   ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝     ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝    ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

  */

  rateUser(double points, userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> point = await FirebaseFirestore
          .instance
          .collection("Users")
          .where("userId", isEqualTo: userId)
          .get();
      double mainPoints = (double.parse(point.docs[0]["Points"]) + points) / 2;
      QuerySnapshot newData = await FirebaseFirestore.instance
          .collection("Users")
          .where("userId", isEqualTo: userId)
          .get();

      for (var data in newData.docs) {
        data.reference.update({"Points": mainPoints.toString()});
      }
    } catch (e) {
      print(e);
    }
  }

  /*
   █████╗  ██████╗████████╗██╗██╗   ██╗ █████╗ ████████╗███████╗    ████████╗██████╗  █████╗ ██████╗ ███████╗
  ██╔══██╗██╔════╝╚══██╔══╝██║██║   ██║██╔══██╗╚══██╔══╝██╔════╝    ╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝
  ███████║██║        ██║   ██║██║   ██║███████║   ██║   █████╗         ██║   ██████╔╝███████║██║  ██║█████╗
  ██╔══██║██║        ██║   ██║╚██╗ ██╔╝██╔══██║   ██║   ██╔══╝         ██║   ██╔══██╗██╔══██║██║  ██║██╔══╝
  ██║  ██║╚██████╗   ██║   ██║ ╚████╔╝ ██║  ██║   ██║   ███████╗       ██║   ██║  ██║██║  ██║██████╔╝███████╗
  ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚═╝  ╚═╝   ╚═╝   ╚══════╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝

  */

  addActiveTrade(context, userId, tradeId, tradeCat) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(userId).update({
        "ActiveTradeId": tradeId,
        "ActiveTradeCat": tradeCat
      }).timeout(const Duration(seconds: 30));
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
  ██████╗ ███████╗ █████╗  ██████╗████████╗██╗██╗   ██╗ █████╗ ████████╗███████╗    ████████╗██████╗  █████╗ ██████╗ ███████╗
  ██╔══██╗██╔════╝██╔══██╗██╔════╝╚══██╔══╝██║██║   ██║██╔══██╗╚══██╔══╝██╔════╝    ╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝
  ██║  ██║█████╗  ███████║██║        ██║   ██║██║   ██║███████║   ██║   █████╗         ██║   ██████╔╝███████║██║  ██║█████╗
  ██║  ██║██╔══╝  ██╔══██║██║        ██║   ██║╚██╗ ██╔╝██╔══██║   ██║   ██╔══╝         ██║   ██╔══██╗██╔══██║██║  ██║██╔══╝
  ██████╔╝███████╗██║  ██║╚██████╗   ██║   ██║ ╚████╔╝ ██║  ██║   ██║   ███████╗       ██║   ██║  ██║██║  ██║██████╔╝███████╗
  ╚═════╝ ╚══════╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚═╝  ╚═╝   ╚═╝   ╚══════╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝

  */

  removeActiveTrade(context, userId) async {
    try {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userId)
          .update({"ActiveTradeId": null, "ActiveTradeCat": null}).timeout(
              const Duration(seconds: 30));
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

/*
 ██████╗ ███████╗████████╗     █████╗  ██████╗████████╗██╗██╗   ██╗███████╗    ████████╗██████╗  █████╗ ██████╗ ███████╗
██╔════╝ ██╔════╝╚══██╔══╝    ██╔══██╗██╔════╝╚══██╔══╝██║██║   ██║██╔════╝    ╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝
██║  ███╗█████╗     ██║       ███████║██║        ██║   ██║██║   ██║█████╗         ██║   ██████╔╝███████║██║  ██║█████╗
██║   ██║██╔══╝     ██║       ██╔══██║██║        ██║   ██║╚██╗ ██╔╝██╔══╝         ██║   ██╔══██╗██╔══██║██║  ██║██╔══╝
╚██████╔╝███████╗   ██║       ██║  ██║╚██████╗   ██║   ██║ ╚████╔╝ ███████╗       ██║   ██║  ██║██║  ██║██████╔╝███████╗
 ╚═════╝ ╚══════╝   ╚═╝       ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝

*/
  Future getActiveTrades(context, userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("Users")
          .doc(userId)
          .get();
      return data;
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
  ██████╗ ███████╗██╗     ███████╗████████╗███████╗     █████╗     ██████╗  ██████╗  ██████╗██╗   ██╗███╗   ███╗███████╗███╗   ██╗████████╗
  ██╔══██╗██╔════╝██║     ██╔════╝╚══██╔══╝██╔════╝    ██╔══██╗    ██╔══██╗██╔═══██╗██╔════╝██║   ██║████╗ ████║██╔════╝████╗  ██║╚══██╔══╝
  ██║  ██║█████╗  ██║     █████╗     ██║   █████╗      ███████║    ██║  ██║██║   ██║██║     ██║   ██║██╔████╔██║█████╗  ██╔██╗ ██║   ██║
  ██║  ██║██╔══╝  ██║     ██╔══╝     ██║   ██╔══╝      ██╔══██║    ██║  ██║██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║
  ██████╔╝███████╗███████╗███████╗   ██║   ███████╗    ██║  ██║    ██████╔╝╚██████╔╝╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗██║ ╚████║   ██║
  ╚═════╝ ╚══════╝╚══════╝╚══════╝   ╚═╝   ╚══════╝    ╚═╝  ╚═╝    ╚═════╝  ╚═════╝  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝

  */

  Future deleteADocument(context, prodId, prodCat) async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection(prodCat)
          .where(TradeFormModel().productId, isEqualTo: prodId)
          .get();

      for (var dat in data.docs) {
        await dat.reference.delete();
        await FirebaseStorage.instance
            .refFromURL(dat[TradeFormModel().img])
            .delete();
      }

      if (prodCat == "Auction") {
        QuerySnapshot<Map<String, dynamic>> bidData = await FirebaseFirestore
            .instance
            .collection("Bids")
            .where(TradeFormModel().bidOn, isEqualTo: prodId)
            .get();

        for (var dat in bidData.docs) {
          await dat.reference.delete();
          await FirebaseStorage.instance
              .refFromURL(dat[TradeFormModel().img])
              .delete();
        }
      }
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
   ██████╗ ███████╗████████╗    ██████╗ ██████╗  ██████╗ ██████╗ ███████╗    ██╗███╗   ██╗    ██╗    ██╗██╗███████╗██╗  ██╗██╗     ██╗███████╗████████╗
  ██╔════╝ ██╔════╝╚══██╔══╝    ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗██╔════╝    ██║████╗  ██║    ██║    ██║██║██╔════╝██║  ██║██║     ██║██╔════╝╚══██╔══╝
  ██║  ███╗█████╗     ██║       ██████╔╝██████╔╝██║   ██║██║  ██║███████╗    ██║██╔██╗ ██║    ██║ █╗ ██║██║███████╗███████║██║     ██║███████╗   ██║
  ██║   ██║██╔══╝     ██║       ██╔═══╝ ██╔══██╗██║   ██║██║  ██║╚════██║    ██║██║╚██╗██║    ██║███╗██║██║╚════██║██╔══██║██║     ██║╚════██║   ██║
  ╚██████╔╝███████╗   ██║       ██║     ██║  ██║╚██████╔╝██████╔╝███████║    ██║██║ ╚████║    ╚███╔███╔╝██║███████║██║  ██║███████╗██║███████║   ██║
   ╚═════╝ ╚══════╝   ╚═╝       ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝    ╚═╝╚═╝  ╚═══╝     ╚══╝╚══╝ ╚═╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝╚══════╝   ╚═╝

  */

  getWishlistProducts(
      context, NotificationController controller, prodCat, prodId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection(prodCat)
          .where(TradeFormModel().productId, isEqualTo: prodId)
          .get();

      controller.addToData(data);
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
  ███╗   ███╗ █████╗ ██████╗ ██╗  ██╗    ██████╗ ██████╗  ██████╗ ██████╗      █████╗ ███████╗    ██╗███╗   ██╗     █████╗  ██████╗████████╗██╗██╗   ██╗███████╗
  ████╗ ████║██╔══██╗██╔══██╗██║ ██╔╝    ██╔══██╗██╔══██╗██╔═══██╗██╔══██╗    ██╔══██╗██╔════╝    ██║████╗  ██║    ██╔══██╗██╔════╝╚══██╔══╝██║██║   ██║██╔════╝
  ██╔████╔██║███████║██████╔╝█████╔╝     ██████╔╝██████╔╝██║   ██║██║  ██║    ███████║███████╗    ██║██╔██╗ ██║    ███████║██║        ██║   ██║██║   ██║█████╗
  ██║╚██╔╝██║██╔══██║██╔══██╗██╔═██╗     ██╔═══╝ ██╔══██╗██║   ██║██║  ██║    ██╔══██║╚════██║    ██║██║╚██╗██║    ██╔══██║██║        ██║   ██║╚██╗ ██╔╝██╔══╝
  ██║ ╚═╝ ██║██║  ██║██║  ██║██║  ██╗    ██║     ██║  ██║╚██████╔╝██████╔╝    ██║  ██║███████║    ██║██║ ╚████║    ██║  ██║╚██████╗   ██║   ██║ ╚████╔╝ ███████╗
  ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝    ╚═╝     ╚═╝  ╚═╝ ╚═════╝ ╚═════╝     ╚═╝  ╚═╝╚══════╝    ╚═╝╚═╝  ╚═══╝    ╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚═╝  ╚═══╝  ╚══════╝

  */

  markAsinActive(context, prodId) async {
    try {
      await FirebaseFirestore.instance
          .collection("Auction")
          .where(TradeFormModel().productId, isEqualTo: prodId)
          .get()
          .then((value) {
        for (var ele in value.docs) {
         ele.reference.update({TradeFormModel().isActive: "False"});
        }
      });
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
   ██████╗ ███████╗████████╗     █████╗ ██╗     ██╗         ████████╗██████╗  █████╗ ██████╗ ███████╗███████╗    ███████╗ ██████╗ ██████╗      █████╗     ██╗   ██╗███████╗███████╗██████╗
  ██╔════╝ ██╔════╝╚══██╔══╝    ██╔══██╗██║     ██║         ╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝    ██╔════╝██╔═══██╗██╔══██╗    ██╔══██╗    ██║   ██║██╔════╝██╔════╝██╔══██╗
  ██║  ███╗█████╗     ██║       ███████║██║     ██║            ██║   ██████╔╝███████║██║  ██║█████╗  ███████╗    █████╗  ██║   ██║██████╔╝    ███████║    ██║   ██║███████╗█████╗  ██████╔╝
  ██║   ██║██╔══╝     ██║       ██╔══██║██║     ██║            ██║   ██╔══██╗██╔══██║██║  ██║██╔══╝  ╚════██║    ██╔══╝  ██║   ██║██╔══██╗    ██╔══██║    ██║   ██║╚════██║██╔══╝  ██╔══██╗
  ╚██████╔╝███████╗   ██║       ██║  ██║███████╗███████╗       ██║   ██║  ██║██║  ██║██████╔╝███████╗███████║    ██║     ╚██████╔╝██║  ██║    ██║  ██║    ╚██████╔╝███████║███████╗██║  ██║
   ╚═════╝ ╚══════╝   ╚═╝       ╚═╝  ╚═╝╚══════╝╚══════╝       ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝    ╚═╝      ╚═════╝ ╚═╝  ╚═╝    ╚═╝  ╚═╝     ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝

  */

  getAllUserTrades(context, userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("Trade")
          .where(TradeFormModel().userId, isEqualTo: userId)
          .get();

      return data;
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
   █████╗  ██████╗ ██████╗███████╗██████╗ ████████╗    ██████╗ ██╗██████╗
  ██╔══██╗██╔════╝██╔════╝██╔════╝██╔══██╗╚══██╔══╝    ██╔══██╗██║██╔══██╗
  ███████║██║     ██║     █████╗  ██████╔╝   ██║       ██████╔╝██║██║  ██║
  ██╔══██║██║     ██║     ██╔══╝  ██╔═══╝    ██║       ██╔══██╗██║██║  ██║
  ██║  ██║╚██████╗╚██████╗███████╗██║        ██║       ██████╔╝██║██████╔╝
  ╚═╝  ╚═╝ ╚═════╝ ╚═════╝╚══════╝╚═╝        ╚═╝       ╚═════╝ ╚═╝╚═════╝

  */

  acceptBid(context, bidTitle) async {
    try {
      QuerySnapshot<Map<String, dynamic>> data = await FirebaseFirestore
          .instance
          .collection("Bids")
          .where(TradeFormModel().title, isEqualTo: bidTitle)
          .get();

      for (var dat in data.docs) {
       await dat.reference.update({TradeFormModel().isAccepted: true});
      }
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

  /*
      ███████╗███╗   ██╗██████╗      ██████╗ ███████╗    ███████╗██╗   ██╗███╗   ██╗ ██████╗████████╗██╗ ██████╗ ███╗   ██╗
      ██╔════╝████╗  ██║██╔══██╗    ██╔═══██╗██╔════╝    ██╔════╝██║   ██║████╗  ██║██╔════╝╚══██╔══╝██║██╔═══██╗████╗  ██║
      █████╗  ██╔██╗ ██║██║  ██║    ██║   ██║█████╗      █████╗  ██║   ██║██╔██╗ ██║██║        ██║   ██║██║   ██║██╔██╗ ██║
      ██╔══╝  ██║╚██╗██║██║  ██║    ██║   ██║██╔══╝      ██╔══╝  ██║   ██║██║╚██╗██║██║        ██║   ██║██║   ██║██║╚██╗██║
      ███████╗██║ ╚████║██████╔╝    ╚██████╔╝██║         ██║     ╚██████╔╝██║ ╚████║╚██████╗   ██║   ██║╚██████╔╝██║ ╚████║
      ╚══════╝╚═╝  ╚═══╝╚═════╝      ╚═════╝ ╚═╝         ╚═╝      ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝   ╚═╝   ╚═╝ ╚═════╝ ╚═╝  ╚═══╝

  */
}
