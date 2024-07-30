import 'dart:developer';
import 'package:animattio_mobile_app/pages/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final fireStore = FirebaseFirestore.instance;

  createUser(User user){
    try{
      fireStore.collection("users").add(user.toMap());

    }catch(e){
      log(e.toString());
    }
  }
}