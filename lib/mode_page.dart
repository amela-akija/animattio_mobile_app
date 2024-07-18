import 'package:animattio_mobile_app/start_game_page.dart';
import 'package:animattio_mobile_app/user_page.dart';
import 'package:flutter/material.dart';

class ModePage extends StatefulWidget {
  const ModePage({super.key});

  @override
  _ModePageState createState() => _ModePageState();
}

class _ModePageState extends State<ModePage> {
  List<String> modes = [
    "Click on the screen only when given symbol is displayed",
    "Click on the screen only when given symbol is NOT displayed"
  ];
  int currentIndex = 0;

  void _showNextMode() {
    setState(() {
      currentIndex = (currentIndex + 1) % modes.length;
    });
  }

  void _showPreviousMode() {
    setState(() {
      currentIndex = (currentIndex - 1 + modes.length) % modes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    String themeTitle = "Choose mode:";
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFFEFFD9);
    Color fontColor = const Color(0xFFF7A559);
    Color titleColor = const Color(0xFFFEFFD9);

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Center(
            child: Transform.scale(
              scale: 1.3,
              child: Image.asset(
                'assets/mode_page/mode_field.png',
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Transform.translate(
              offset: const Offset(0, 0),
              child: Transform.scale(
                scale: 1,
                child: Image.asset(
                  'assets/mode_page/star_mode_1.png',
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Transform.translate(
              offset: const Offset(5, 0),
              child: Transform.scale(
                scale: 1,
                child: Image.asset(
                  'assets/mode_page/star_mode_2.png',
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                themeTitle,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 56,
                  fontFamily: "Lilita One",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              child: Text(
                modes[currentIndex],
                style: TextStyle(
                  color: fontColor,
                  fontFamily: "Lilita One",
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.1,
            top: MediaQuery.of(context).size.height * 0.47,
            child: IconButton(
              icon: Icon(Icons.arrow_left, color: fontColor, size: 50),
              onPressed: _showPreviousMode,
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.width * 0.1,
            top: MediaQuery.of(context).size.height * 0.47,
            child: IconButton(
              icon: Icon(Icons.arrow_right, color: fontColor, size: 50),
              onPressed: _showNextMode,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.65,
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
                  'OK',
                  style: TextStyle(color: fontColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


