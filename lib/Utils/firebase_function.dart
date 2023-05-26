import 'package:barter_x/Controllers/Main_Controllers/Route_Controllers/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFunctions {
  void getFirebaseTradeData(HomeController controller)  {
    try {
      controller.refreshData(true);
      Future<QuerySnapshot<Map<String, dynamic>>> data =
          FirebaseFirestore.instance.collection("Trade").get();

      controller.addTradeData(data);
    } catch (e) {
      rethrow;
    }
  }
}
