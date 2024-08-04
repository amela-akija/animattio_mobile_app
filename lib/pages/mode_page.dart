import 'package:animattio_mobile_app/pages/start_game_page.dart';
import 'package:animattio_mobile_app/pages/theme_page.dart';
import 'package:flutter/material.dart';

class ModePage extends StatefulWidget {
  final String chosenTheme;
  const ModePage({super.key, required this.chosenTheme});

  @override
  _ChooseModeState createState() => _ChooseModeState();
}

class _ChooseModeState extends State<ModePage> {
  List<String> modes = [
    "Click on the screen only when given symbol is displayed",
    "Click on the screen only when given symbol is NOT displayed"
  ];
  int currentMode = 0;

  void _showNextMode() {
    setState(() {
      currentMode = (currentMode + 1) % modes.length;
    });
  }

  void _showPreviousMode() {
    setState(() {
      currentMode = (currentMode - 1 + modes.length) % modes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    //Strings
    String themeTitle = "Choose mode:";
    String chosenMode = modes[currentMode];

    //Colors
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFFEFFD9);
    Color fontColor = const Color(0xFFF7A559);
    Color arrowColor = const Color(0xFF2A470C);
    Color titleColor = const Color(0xFF2A470C);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    // final dbService = DatabaseService();

    // User? currentUser = FirebaseAuth.instance.currentUser;
    // String uid = currentUser!.uid;

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Stack(
            children: [
          Positioned(
                left: 0,
                top: height*0.01,
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: buttonColor,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ThemePage();
                      }));
                    },
                  ),
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/mode_page/star_mode_1.png',
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: width * 0.2,
                  height: height * 0.25,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset(
                      'assets/mode_page/mode_field.png',
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                width: width ,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/mode_page/star_mode_2.png',
                  ),
                ),
              ),
            ],
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
                  fontSize: 50,
                  fontFamily: "Lilita One",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              constraints: BoxConstraints(
                maxWidth: deviceSize.width * 0.5,
              ),
              child: Text(
                modes[currentMode],
                style: TextStyle(
                  color: fontColor,
                  fontFamily: "Lilita One",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: Icon(Icons.arrow_left, color: arrowColor, size: 50),
                  onPressed: _showPreviousMode,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: Icon(Icons.arrow_right, color: arrowColor, size: 50),
                  onPressed: _showNextMode,
                ),
              ),
            ],
          ),
          Positioned(
            top: deviceSize.height * 0.75,
            width: deviceSize.width,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  // dbService.addGame(uid,chosenMode, widget.chosenTheme);
                 Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context)=> StartGamePage(chosenTheme: widget.chosenTheme, chosenMode: chosenMode,)
                        ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                  'OK',
                  style: TextStyle(color: arrowColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// class ChosenGame {
//   final String userId;
//   final String mode;
//   final String theme;
  

//   ChosenGame({required this.userId, required this.mode, required this.theme});
//   Map<String, dynamic> toMap() => {"id":userId,"mode": mode, "theme": theme, "timestamp": FieldValue.serverTimestamp()};
// }

