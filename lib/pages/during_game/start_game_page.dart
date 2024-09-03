import 'package:animattio_mobile_app/pages/during_game/instruction_page.dart';
import 'package:animattio_mobile_app/pages/before_game/mode_page.dart';
import 'package:animattio_mobile_app/pages/user_pages/user_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// StartGamePage is a page for ensuring that the user is ready to start the game or not.
///
/// This page contains of two buttons providing two options: yes for continuing with the game and no for cancelation of the game.
/// The layout includes decorative images positioned around the screen. [StartGamePage] has two parameters [chosenTheme] and [chosenMode].
///
class StartGamePage extends StatelessWidget {
  /// [chosenTheme] parameter represent theme chosen on ThemePage.
  final String chosenTheme;

  /// [chosenMode] parameter represent mode chosen on ModePage.
  final String chosenMode;

  /// Creates a [StartGamePage].
  const StartGamePage(
      {super.key, required this.chosenTheme, required this.chosenMode});

  @override
  Widget build(BuildContext context) {
    ///Strings used on page.
    String message = "start_game".tr;
    String yesButton = "yes".tr;
    String noButton = "no".tr;

    /// Color definitions used throughout the page.
    Color pageColor = const Color(0xffD4F8B0);
    Color buttonColor = const Color(0xFFF7A559);
    Color fontColor = const Color(0xFFF7A559);
    Color fontButtonColor = const Color(0xFFFEFFD9);
    Color arrowButton = const Color(0xFF2A470C);

    ///Size of the screen used for a responsive ui.
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    /// [dbService] is an instance of [DatabaseService] used to access all of the methods that interact with the database.
    final dbService = DatabaseService();

    /// [currentUser] is an instance of currently signed in user
    User? currentUser = FirebaseAuth.instance.currentUser;

    /// [uid] is the id of currently signed in user
    String uid = currentUser!.uid;

    /// Main UI of the page composed of multiple stacked elements.
    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: <Widget>[
                    //Image star_start_2
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
                    //Image star_start_1
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
                      fontFamily: "Fredoka",
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
                ///Button for when the user wants to continue with the game.
                ///When pressed the function addGame() is called and user is navigated to InstructionPage
                ///with two parameters [chosenMode] and [chosenTheme]
                ElevatedButton(
                  onPressed: () {
                    dbService.addGame(uid, chosenMode, chosenTheme);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return InstructionPage(
                          chosenMode: chosenMode,
                          chosenThemeList: chosenTheme,
                        );
                      }),
                    );
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

                ///Button for when the user wants to cancel the game.
                ///When pressed the user is navigated to UserPage
                ElevatedButton(
                  onPressed: () {
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

          /// Button that allows the user to go back to ModePage without losing the value of [chosenTheme] parameter.
          Padding(
            padding: EdgeInsets.only(top: height * 0.05),
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: arrowButton,
                iconSize: 30,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ModePage(
                            chosenTheme: chosenTheme,
                          )));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// [ChosenGame] is a class which objects represent games done by the user.
///
/// It contains basic information about the game, including id of user, chosen mode,
/// and chosen theme.
class ChosenGame {
  /// id of the signed in user
  final String userId;

  /// chosen mode by the user
  final String mode;

  /// chosen theme by the user
  final String theme;

  /// Creates a [ChosenGame] instance with provided [userId], [mode], and [theme].
  ///
  /// All fields are required and must be provided when creating a new instance of [ChosenGame].
  ChosenGame({required this.userId, required this.mode, required this.theme});

  /// Converts the [ChosenGame] instance into a map
  ///
  /// Returns a map with keys corresponding to
  /// the game's data with added timestamp.
  Map<String, dynamic> toMap() => {
        "id": userId,
        "mode": mode,
        "theme": theme,
        "timestamp": FieldValue.serverTimestamp()
      };
}
