//import 'package:animattio_mobile_app/login_page.dart';
//import 'package:animattio_mobile_app/signup_page.dart';
import 'package:animattio_mobile_app/user_page.dart';
import 'package:flutter/material.dart';
//import 'main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home:UserPage(),
    );
  }
}
