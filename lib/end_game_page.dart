import 'package:animattio_mobile_app/user_page.dart';
import 'package:flutter/material.dart';

class EndGamePage extends StatelessWidget {
  const EndGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    //Strings
    String message = "You finished the game! Do you want to repeat the task?";
    String yesButton = "yes";
    String noButton = "no";

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
                    height: height ,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.asset('assets/start_game_page/star_start_2.png'),
                    ),
                  ),
                ),
                 Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: width,
                    height: height*0.85 ,
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.asset('assets/start_game_page/star_start_1.png'),
                    ),
                  ),
                ),
                ],),),
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
                  const SizedBox(height: 20),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const UserPage();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

