import 'package:barter_x/Controllers/Main_Controllers/Route_Controllers/home_controller.dart';
import 'package:barter_x/Models/trade_form_model.dart';
import 'package:barter_x/Utils/Widgets/show_modal_sheet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Controllers/Main_Controllers/Route_Controllers/auction_controller.dart';
import '../../Controllers/Main_Controllers/Trade_and_EWaste_SubPages/category_details_controller.dart';
import '../../Controllers/Main_Controllers/Route_Controllers/ewaste_controller.dart';

class FirebaseFunctions {
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

   void getFirebaseTradeDatabyCategory(context, CategoryDetailsController controller , String category) {
    try {
      controller.refreshData(true);
      Future<QuerySnapshot<Map<String, dynamic>>> data =
          FirebaseFirestore.instance.collection("Trade").where(TradeFormModel().cat, isEqualTo: category).get();

      controller.addTradeData(data);
    } catch (e) {
      ReturnWidgets().returnBottomSheet(context, "An Error Occurred $e");
    }
  }

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
}
