import 'package:animattio_mobile_app/pages/start_game_page.dart';
import 'package:flutter/material.dart';

class InstructionPage extends StatefulWidget {
  String chosenMode;
  String chosenTheme;
  InstructionPage({super.key, required this.chosenMode, required this.chosenTheme});

  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {

  @override
  Widget build(BuildContext context) {

     //Strings
    String themeTitle = "Choose mode:";
    String instructionMode1 = "React by clicking on the screen only when this symbol is displayed";
    String instructionMode2 = "React by clicking on the screen only when this symbol is NOT displayed";

    //Colors
    Color pageColor = const Color(0xFFFEFFD9);
    Color textColor = const Color(0xFFF7A559);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;
    return Scaffold(
      backgroundColor: pageColor,
      body:  Container(
        child: Builder(builder: (context){
          if(widget.chosenMode == "xxx"){
            return    Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                    instructionMode1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 32,
                      fontFamily: 'Lilita One',
                    ),
                  ),
            );
          }else{
            return  Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                    instructionMode2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 32,
                      fontFamily: 'Lilita One',
                    ),
                  ),
            );
          }
        }),),

      );

        
       
      
  }
}