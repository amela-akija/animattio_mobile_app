import 'package:animattio_mobile_app/pages/user_page.dart';
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

  loginUser(email,password,context)async{
    try{
      UserCredential? userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user!;

      if(user !=null){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>UserPage()));

      }else{
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User not found. Please register")));
      }

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));

    }
    
  }

}