import 'package:animattio_mobile_app/pages/end_game_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPage extends StatefulWidget {
  final List<bool> tappedImages;
  final List<String> shownImages;
  final String stimuli;
  final String mode;
  final List<int> reactionTimes;
  const ResultPage(
      {super.key,
      required this.shownImages,
      required this.tappedImages,
      required this.stimuli,
      required this.mode,
      required this.reactionTimes});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    //Strings
    String userTitle = "your_result".tr;

    final dbService = DatabaseService();

    //Colors
    Color pageColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);
    Color incorrectColor = const Color.fromARGB(255, 241, 46, 46);
    Color correctColor = const Color.fromARGB(255, 46, 241, 88);
    Color resultColor = const Color(0xFFFEFFD9);

    //Size
    // dynamic deviceSize, height, width;
    // deviceSize = MediaQuery.of(context).size;
    // height = deviceSize.height;
    // width = deviceSize.width;

    List<bool> ignoreFirstValue = widget.tappedImages.sublist(1);

    //Parameters
    int omissionErrors = 0; // stimuli was shown but no reaction
    int commisionErrors =
        0; // non stimuli was shown and there was a reaction - false alarm
    int hitRate = 0; // stimuli was shown and there was a reaction

    if (widget.mode == "mode1".tr) {
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

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: [
          Positioned(
            top:50,
            left:0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
              // Incorrect use of ParentDataWidget.
              itemCount: widget.shownImages.length,
              itemBuilder: (context, index) {
                if (widget.mode == "mode1".tr) {
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
                        ignoreFirstValue[index] ? 'tapped'.tr : 'not_tapped'.tr,
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
            padding: const EdgeInsets.only(top: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                  icon: Icon(Icons.arrow_right, color: fontColor, size: 50),
                  onPressed: () async {
                    await dbService.updateGameWithResult(
                        ignoreFirstValue, //?
                        widget.shownImages, //?
                        commisionErrors,
                        omissionErrors,
                        hitRate,
                        widget.reactionTimes);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const EndGamePage();
                      }),
                    );
                  }),
            ),
          ),
            Padding(
             padding: const EdgeInsets.only(top: 20.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                userTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: fontColor,
                  fontSize: 40,
                  fontFamily: 'Fredoka',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
