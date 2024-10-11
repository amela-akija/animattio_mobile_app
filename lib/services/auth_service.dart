import 'package:animattio_mobile_app/pages/authentication/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// [AuthServices] class contains all of the method used to authenticate app's user.
///
/// It allows for user registration and user sign in to the app.
///
class AuthServices {
  /// Instance of [FirebaseAuth] used for authentication.
  FirebaseAuth auth = FirebaseAuth.instance;

  /// Instance of [FirebaseFirestore] used for fetching user credentials.
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  /// Strings used in authentication methods
  String successfullRegister = 'registered_successfully';
  String successfullLogin = 'login_successfull';
  String emailRepeat = 'email_repeat';
  String unknownError = 'unknown_error';

  /// [registerUser] method is used to register user in the app.
  ///
  /// It requires 5 parameters: [email], [password], [username], [avatar] and [context].
  /// Upon filling the registration form it calls the method createUserWithEmailAndPassword which creates user instance in Firebase
  /// and then creates an instance of [RegisteredUser] class in Firestore collection connecting them by the [uid] parameter.
  registerUser(email, password, String username, String avatar, String role,
      context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      RegisteredUser registeredUser = RegisteredUser(
          username: username, avatar: avatar, role: role);
      await fireStore.collection('users').doc(uid).set(registeredUser.toMap());
      return ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(successfullRegister.tr)));
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == "email-already-in-use") {
          return ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(emailRepeat.tr)));
        }
      } else {
        return ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(unknownError.tr)));
      }
    }
  }

  /// [loginUser] method is used for signing in.
  ///
  /// It requires [email] and [password]. It calls the signInWithEmailAndPassword method and checks provided credentials.
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
