import 'dart:math';
import 'package:animattio_mobile_app/pages/game_page.dart';
import 'package:animattio_mobile_app/pages/game_page_2.dart';
import 'package:animattio_mobile_app/poviders/images_provider.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
    int stimuliIndex = random.nextInt(listOfImages.length);
    String stimuli = listOfImages[stimuliIndex];

    //Strings
    String instructionMode1 = "instructionMode1".tr;
    String instructionMode2 = "instructionMode2".tr;
    String message = "message".tr;

    //Colors
    Color pageColor = const Color(0xFFFEFFD9);
    Color textColor = const Color(0xFFF7A559);

    //Size
    dynamic deviceSize, height;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;

    final dbService = DatabaseService();


    return Scaffold(
      backgroundColor: pageColor,
      body: GestureDetector(
        child: Column(
          children: [
            Builder(builder: (context) {
              if (widget.chosenMode == "mode1".tr) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    instructionMode1,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 32,
                      fontFamily: 'Fredoka',
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
                      fontFamily: 'Fredoka',
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
                    fontSize: 18,
                    fontFamily: 'Fredoka',
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
        onTap: () {
          dbService.updateGameWithStimuli(stimuli);
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return GamePage(stimuli: stimuli, listOfImages: listOfImages, mode: widget.chosenMode,
                );
              }),
            );
  
        },
      ),
    );
  }
}
