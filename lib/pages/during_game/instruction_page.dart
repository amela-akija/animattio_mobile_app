import 'dart:math';
import 'package:animattio_mobile_app/pages/during_game/game_page.dart';
import 'package:animattio_mobile_app/poviders/images_provider.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

/// InstructionPage is a page where user is assigned the stimuli to which they must ract and an explanation how does the game works.
///
/// This page contains of a random image chosem from the list of images within the chosen theme.
///  [InstructionPage] has two parameters [chosenThemeList] and [chosenMode].
///
// ignore: must_be_immutable
class InstructionPage extends StatefulWidget {
  /// [chosenMode] is a mode chosen by user on ModePage.
  String chosenMode;

  /// [chosenThemeList] is a theme chosen on ThemePage.
  final String chosenThemeList;

  /// Creates a [InstructionPage].
  InstructionPage(
      {super.key, required this.chosenMode, required this.chosenThemeList});

  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {
  @override
  Widget build(BuildContext context) {
    /// Instance of [ImagesProvider] that provides correct list based on [chosenThemeList].
    final listProvider = Provider.of<ImagesProvider>(context);

    /// [listOfImages] is the result of [getList] that searches for a list of images associated with provided key.
    List<String> listOfImages = listProvider.getList(widget.chosenThemeList);

    /// Instance of [Random] that is used to pick random stimuli.
    Random random = Random();

    /// [stimuliIndex] is randomly generated number that is used to pick stimuli from list.
    int stimuliIndex = random.nextInt(listOfImages.length);

    /// [stimuli] is the randomly chosen image.
    String stimuli = listOfImages[stimuliIndex];

    ///Strings used on page.
    String instructionMode1 = "instructionMode1".tr;
    String instructionMode2 = "instructionMode2".tr;
    String message = "message".tr;
    String message2 = "message2".tr;

    /// Color definitions used throughout the page.
    Color pageColor = const Color(0xFFFEFFD9);
    Color textColor = const Color(0xFFF7A559);

    ///Size of the screen used for a responsive ui.
    dynamic deviceSize, height;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;

    /// [dbService] is an instance of [DatabaseService] used to access all of the methods that interact with the database.
    final dbService = DatabaseService();

    /// Main UI of the page composed of multiple stacked elements.
    return Scaffold(
      backgroundColor: pageColor,
      body: GestureDetector(
        child: Column(
          children: [
            // Displayed instruction base on the chosen mode
            Builder(builder: (context) {
              print(widget.chosenMode);
              if (widget.chosenMode == "mode1".tr ||
                  widget.chosenMode == "mode1") {
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
              // Message informing to save the game
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  message2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontFamily: 'Fredoka',
                  ),
                ),
              ),
            ),
            // Message informing to tap the screen to continue
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
            // Displayed stimuli
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
          /// When the screen is tapped the game is updated with a stimuli field
          /// and user is navigated to GamePage with parameters: [stimuli], [listOfImages] and [chosenMode].
          dbService.updateGameWithStimuli(stimuli);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return GamePage(
                stimuli: stimuli,
                listOfImages: listOfImages,
                mode: widget.chosenMode,
              );
            }),
          );
        },
      ),
    );
  }
}
