import 'package:animattio_mobile_app/pages/signup_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  registerUser(email, password, String username, String avatar, context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      RegisteredUser registeredUser =
          RegisteredUser(username: username, email: email, avatar: avatar);
      await fireStore.collection('users').doc(uid).set(registeredUser.toMap());
      return ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User registered successfully')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
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
      return 'User logged in successfully!';
    } on FirebaseAuthException {
      if (email.isEmpty || password.isEmpty) {
        return "Please fill in all the fields";
      } else {
        return "Wrong credentials";
      }
    } catch (e) {
      return e.toString();
    }
  }
}
