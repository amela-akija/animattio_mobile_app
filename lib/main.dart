//import 'package:animattio_mobile_app/login_page.dart';
//import 'package:animattio_mobile_app/main_page.dart';
//import 'package:animattio_mobile_app/signup_page.dart';
//import 'end_game_page.dart';
//import 'package:animattio_mobile_app/avatar_page.dart';
//import 'package:animattio_mobile_app/main_page.dart';
//import 'package:animattio_mobile_app/avatar_page.dart';
//import 'package:animattio_mobile_app/mode_page.dart';
//import 'package:animattio_mobile_app/theme_page.dart';
//import 'package:animattio_mobile_app/theme_page.dart';
//import 'package:animattio_mobile_app/user_page.dart';
import 'package:animattio_mobile_app/start_game_page.dart';
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
      home:StartGamePage(),
    );
  }
}
