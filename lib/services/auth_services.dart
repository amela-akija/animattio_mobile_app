import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices{
  FirebaseAuth auth = FirebaseAuth.instance;

  registerUser(email, password, context)async{
    try{
    await auth.createUserWithEmailAndPassword(email: email, password: password).then((value){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User registered successfully')));

    });

    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
    }

  }

}