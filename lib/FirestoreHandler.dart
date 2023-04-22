import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreHandler {
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static Future<void> addUser(String userID) async {
    db.collection("users").doc(userID).set({});
  }
  // static Future<QuerySnapshot<Map<String, dynamic>>> getUserInfo(){

  // }
  static Future<void> addTicket(String ticketID, String userID) async {
    db
        .collection("users")
        .doc(userID)
        .collection("tickets")
        .add({"ticket": ticketID, "price": 50});
  }
}
