import 'package:animattio_mobile_app/pages/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  String successfullRegister = 'registered_successfully';
   String successfullLogin = 'login_successfull';
   String emailRepeat = 'email_repeat';
   String unknownError = 'unknown_error';

  registerUser(email, password, String username, String avatar, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      RegisteredUser registeredUser =
          RegisteredUser(username: username, email: email, avatar: avatar);
      await fireStore.collection('users').doc(uid).set(registeredUser.toMap());
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(successfullRegister.tr)));
    } catch (e) {
      if (e is FirebaseAuthException) {
    if (e.code == "email-already-in-use") {
     return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(emailRepeat.tr)));
    }
  } else {
    return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(unknownError.tr)));
  }
    }
  }

  Future<String?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'login_successfull'.tr;
    } on FirebaseAuthException {
      if (email.isEmpty || password.isEmpty) {
        return "fields".tr;
      } else {
        return "credentials".tr;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
