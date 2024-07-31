import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final fireStore = FirebaseFirestore.instance;

  addAvatar(String avatar) {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      var userCollection = FirebaseFirestore.instance.collection("users");
      userCollection
          .doc(currentUser?.uid)
          .update({'avatar': avatar}).catchError(
              (error) => print('Update failed: $error'));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> getAvatar() async{
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      var userCollection = FirebaseFirestore.instance.collection("users");
      var currentUserData = await userCollection.doc(currentUser?.uid).get();
      if(currentUserData.exists){
        return currentUserData.data()?['avatar'] ?? "no_avatar.png";
      }
      else{
        return "User doesn't exists";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
