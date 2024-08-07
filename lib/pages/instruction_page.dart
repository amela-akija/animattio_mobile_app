import 'dart:math';
import 'package:animattio_mobile_app/pages/game_page_1.dart';
import 'package:animattio_mobile_app/pages/game_page_2.dart';
import 'package:animattio_mobile_app/poviders/images_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class InstructionPage extends StatefulWidget {
  String chosenMode;
  final String chosenThemeList;
  InstructionPage(
      {super.key, required this.chosenMode, required this.chosenThemeList});

  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  @override
  Widget build(BuildContext context) {
     final listProvider = Provider.of<ImagesProvider>(context);
    List<String> listOfImages = listProvider.getList(widget.chosenThemeList);

    Random random = Random();
    int randomIndex = random.nextInt(listOfImages.length);
    String stimuli = listOfImages[randomIndex];

    //Strings
    String instructionMode1 =
        "React by clicking on the screen only when this symbol is displayed";
    String instructionMode2 =
        "React by clicking on the screen only when this symbol is NOT displayed";
    String message = "Click on the screen to begin the game";

    //Colors
    Color pageColor = const Color(0xFFFEFFD9);
    Color textColor = const Color(0xFFF7A559);

    //Size
    dynamic deviceSize, height;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;

    return Scaffold(
      backgroundColor: pageColor,
      body: GestureDetector(
        child: Column(
          children: [
            Builder(builder: (context) {
              if (widget.chosenMode ==
                  "Click on the screen only when given symbol is displayed") {
                return Padding(
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
              } else {
                return Padding(
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
            }),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 12,
                    fontFamily: 'Lilita One',
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: height * 0.5,
                child: Image.asset(
                  stimuli,
                ),
              ),
            ),
          ],
        ),
        //TODO: all of the parameters
        onTap: () {
          if (widget.chosenMode ==
              "Click on the screen only when given symbol is displayed") {
             Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return  GamePage2(stimuli: stimuli, listOfImages: listOfImages,);
                      }),
                    );
          } else {
            Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return  GamePage2(stimuli: stimuli, listOfImages: listOfImages,);
                      }),
                    );
          }
        },
      ),
    );
  }
}
