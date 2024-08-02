import 'dart:developer';
import 'package:animattio_mobile_app/pages/mode_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final fireStore = FirebaseFirestore.instance;

  addAvatar(String avatar) {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      var userCollection = fireStore.collection("users");
      userCollection
          .doc(currentUser?.uid)
          .update({'avatar': avatar}).catchError(
              (error) => print('Update failed: $error'));
    } catch (e) {
      log(e.toString());
    }
  }

  Future<String> getAvatar() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      var userCollection = fireStore.collection("users");
      var currentUserData = await userCollection.doc(currentUser?.uid).get();
      if (currentUserData.exists) {
        return currentUserData.data()?['avatar'] ?? 'assets/user_page/no_avatar.png';
      } else {
        return "User doesn't exists";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  addGame(String userId, String mode, String theme) async {
    try {
      ChosenGame chosenGame =
          ChosenGame(userId: userId, mode: mode, theme: theme);
      await fireStore.collection('games').add(chosenGame.toMap());
    } catch (e) {
      log(e.toString());
    }
  }

  deleteGame(){
    try{
      fireStore.collection("games").orderBy('timestamp', descending: true)
      .get().then((value){
        value.docs.first.reference.delete();
      }
      );
    }catch(e){
      log(e.toString());

    }
  }
}