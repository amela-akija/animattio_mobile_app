import 'package:flutter/material.dart';

class StartGamePage extends StatelessWidget {
  const StartGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    String message = "Are you ready to start the game?";
    Color pageColor = const Color(0xffD4F8B0);
    Color buttonColor = const Color(0xFFF7A559);
    Color fontColor = const Color(0xFFF7A559);
    Color fontButtonColor = const Color(0xFFFEFFD9);
   

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            top: 100,
            child: Transform.scale(
              scale: 1.2,
              child: Image.asset(
                'assets/start_game_page/star_start_2.png',
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 200,
            child: Transform.scale(
              scale: 1.2,
              child: Image.asset(
                'assets/start_game_page/star_start_1.png',
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                message,
                style: TextStyle(
                  color: fontColor,
                  fontSize: 50,
                  fontFamily: "Lilita One",
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const StartGamePage();
                    }),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 25,
                      fontFamily: 'Lilita One',
                      fontWeight: FontWeight.w900),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
                child: Text(
                  'continue',
                  style: TextStyle(color: fontButtonColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

