import 'package:flutter/material.dart';

class StartGamePage extends StatelessWidget {
  const StartGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    //Strings
    String message = "Are you ready to start the game?";
    String continueButton = "continue";

    //Colors
    Color pageColor = const Color(0xffD4F8B0);
    Color buttonColor = const Color(0xFFF7A559);
    Color fontColor = const Color(0xFFF7A559);
    Color fontButtonColor = const Color(0xFFFEFFD9);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
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
          Positioned(
            top: deviceSize.height * 0.6,
            width: deviceSize.width,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  continueButton,
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
