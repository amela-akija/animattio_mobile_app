import 'package:animattio_mobile_app/pages/after_game/end_game_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ResultPage is a page where the result of the game is displayed.
///
/// This page contains of a Listbuilder with images and messages whether the image was tapped or not.
///  [ResultPage] has six parameters [tappedImages], [shownImages], [stimuli], [reactionTimes], [intervals] and [mode].
///
class ResultPage extends StatefulWidget {
  /// [tappedImages] list contains information about indexes of the images that were tapped during the game.
  final List<bool> tappedImages;

  /// [shownImages] list contains all of the images that were shown during the game.
  final List<String> shownImages;

  /// [stimuli] is the randomly chosen image in InstructionPage.
  final String stimuli;

  /// [mode] is the chosen mode in ModePage.
  final String mode;

  /// [reactionTimes] list contains all of the reaction times that were calculated during the game.
  final List<int> reactionTimes;

  /// [intervals] list contains information about the order of intervals.
  final List<int> intervals;

  /// Creates a [ResultPage].
  const ResultPage(
      {super.key,
      required this.shownImages,
      required this.tappedImages,
      required this.stimuli,
      required this.mode,
      required this.reactionTimes,
      required this.intervals});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  final dbService = DatabaseService(); 

  @override
  void initState() {
    super.initState();
    _updateGameResults(); 
  }

  Future<void> _updateGameResults() async {
    List<bool> ignoreFirstValue = widget.tappedImages.sublist(1);
    int omissionErrors = 0;
    int commisionErrors = 0;
    int hitRate = 0;

    if (widget.mode == "mode1".tr || widget.mode == "mode1") {
      for (int i = 0; i < ignoreFirstValue.length; i++) {
        if (ignoreFirstValue[i] == true) {
          if (widget.shownImages[i] == widget.stimuli) {
            hitRate++;
          } else {
            commisionErrors++;
          }
        } else {
          if (widget.shownImages[i] == widget.stimuli) {
            omissionErrors++;
          }
        }
      }
    } else {
      for (int i = 0; i < ignoreFirstValue.length; i++) {
        if (ignoreFirstValue[i] == true) {
          if (widget.shownImages[i] == widget.stimuli) {
            commisionErrors++;
          } else {
            hitRate++;
          }
        } else {
          if (widget.shownImages[i] != widget.stimuli) {
            omissionErrors++;
          }
        }
      }
    }

    await dbService.updateGameWithResult(
      ignoreFirstValue,
      widget.shownImages,
      commisionErrors,
      omissionErrors,
      hitRate,
      widget.reactionTimes,
      widget.intervals,
    );
  }

  @override
  Widget build(BuildContext context) {
    Color pageColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);
    Color incorrectColor = const Color.fromARGB(255, 241, 46, 46);
    Color correctColor = const Color.fromARGB(255, 46, 241, 88);
    Color resultColor = const Color(0xFFFEFFD9);

    List<bool> ignoreFirstValue = widget.tappedImages.sublist(1);
    dynamic deviceSize, height;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;

return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: pageColor,
        body: Stack(
          children: [
            Positioned(
              top: 30,
              left: 0,
              right: 0,
              bottom: 0,
              child: ListView.builder(
                itemCount: widget.shownImages.length,
                itemBuilder: (context, index) {
                  if (widget.mode == "mode1".tr || widget.mode == "mode1") {
                    if (widget.shownImages[index] == widget.stimuli) {
                      if (ignoreFirstValue[index] == true) {
                        resultColor = correctColor;
                      } else {
                        resultColor = incorrectColor;
                      }
                    } else {
                      if (ignoreFirstValue[index] == false) {
                        resultColor = correctColor;
                      } else {
                        resultColor = incorrectColor;
                      }
                    }
                  } else {
                    if (widget.shownImages[index] == widget.stimuli) {
                      if (ignoreFirstValue[index] == true) {
                        resultColor = incorrectColor;
                      } else {
                        resultColor = correctColor;
                      }
                    } else {
                      if (ignoreFirstValue[index] == false) {
                        resultColor = incorrectColor;
                      } else {
                        resultColor = correctColor;
                      }
                    }
                  }

                  return Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          widget.shownImages[index],
                          height: 150,
                          width: 150,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          ignoreFirstValue[index]
                              ? 'tapped'.tr
                              : 'not_tapped'.tr,
                          style: TextStyle(
                            color: resultColor,
                            fontSize: 30,
                            fontFamily: 'Fredoka',
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.06),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const EndGamePage();
                      }),
                    );
                  },
                  child: Text(
                    'continue'.tr, 
                    style: TextStyle(
                      color: fontColor,
                      fontSize: 22,
                      fontFamily: 'Lilita One',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
