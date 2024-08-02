import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {

    //Strings
    String themeTitle = "Choose theme";
    String chosenTheme = "";

    //Colors
    Color pageColor = const Color(0xFFFEFFD9);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;
    return Scaffold(

      backgroundColor: pageColor,
      body: const Stack(
        children: <Widget>[
         

        ],
        ),
    );
  }
}