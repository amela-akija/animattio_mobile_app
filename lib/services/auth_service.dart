import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices{
  FirebaseAuth auth = FirebaseAuth.instance;

  registerUser(email, password, context)async{
    try{
    await auth.createUserWithEmailAndPassword(email: email, password: password).then((value){

    });
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User registered successfully')));


    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
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
      if(email.isEmpty || password.isEmpty){
        return "Please fill in all the fields";
      }else {
        return "Wrong credentials";
      }
    } catch (e) {
      return e.toString();
    }
  }}