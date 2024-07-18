import 'package:animattio_mobile_app/user_page.dart';
import 'package:flutter/material.dart';

class EndGamePage extends StatelessWidget {
  const EndGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    String message = "You finished the game! Do you want to repeat the task?";
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 44,
                      fontFamily: "Lilita One",
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          'yes',
                          style: TextStyle(color: fontButtonColor),
                        ),
                      ),
                      SizedBox(width: 30),
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
                          'no',
                          style: TextStyle(color: fontButtonColor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

