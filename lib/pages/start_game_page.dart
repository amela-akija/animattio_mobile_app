import 'package:animattio_mobile_app/pages/game_page2.dart';
import 'package:animattio_mobile_app/pages/game_page_1.dart';
import 'package:animattio_mobile_app/pages/user_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class StartGamePage extends StatelessWidget {
  final String chosenTheme;
  final String chosenMode;
  const StartGamePage(
      {super.key, required this.chosenTheme, required this.chosenMode});

  @override
  Widget build(BuildContext context) {
    //Strings
    String message = "Are you ready to start the game?";
    String yesButton = "yes";
    String noButton = "no";

    //Colors
    Color pageColor = const Color(0xffD4F8B0);
    Color buttonColor = const Color(0xFFF7A559);
    Color fontColor = const Color(0xFFF7A559);
    Color fontButtonColor = const Color(0xFFFEFFD9);
    Color arrowButton = const Color(0xFF2A470C);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    final dbService = DatabaseService();

    User? currentUser = FirebaseAuth.instance.currentUser;
    String uid = currentUser!.uid;

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: arrowButton,
                iconSize: 30,
                onPressed: () {
                  dbService.deleteGame();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const UserPage();
                  }));
                },
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset(
                              'assets/start_game_page/star_start_2.png'),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: width,
                        height: height * 0.85,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset(
                              'assets/start_game_page/star_start_1.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                      fontSize: 44,
                      fontFamily: "Lilita One",
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    dbService.addGame(uid, chosenMode, chosenTheme);
                    if(chosenMode == "Click on the screen only when given symbol is displayed"){
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const GamePage1();
                      }),
                    );}
                    else{
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const GamePage2();
                      }),
                    );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lilita One',
                        fontWeight: FontWeight.w900),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 10,
                  ),
                  child: Text(
                    yesButton,
                    style: TextStyle(color: fontButtonColor),
                  ),
                ),
                const SizedBox(width: 30),
                ElevatedButton(
                  onPressed: () {
                    dbService.deleteGame();
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const UserPage();
                      }),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lilita One',
                        fontWeight: FontWeight.w900),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 10,
                  ),
                  child: Text(
                    noButton,
                    style: TextStyle(color: fontButtonColor),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChosenGame {
  final String userId;
  final String mode;
  final String theme;

  ChosenGame({required this.userId, required this.mode, required this.theme});
  Map<String, dynamic> toMap() => {
        "id": userId,
        "mode": mode,
        "theme": theme,
        "timestamp": FieldValue.serverTimestamp()
      };
}
