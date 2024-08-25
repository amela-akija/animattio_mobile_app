import 'package:animattio_mobile_app/pages/end_game_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPage extends StatefulWidget {
  final List<bool> tappedImages;
  final List<String> shownImages;
  final String stimuli;
  final String mode;
  const ResultPage(
      {super.key,
      required this.shownImages,
      required this.tappedImages,
      required this.stimuli, required this.mode});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    //Strings
    String userTitle = "your_result".tr;
    String gameButton = "continue".tr;
    // String result = 'your_result';

    final dbService = DatabaseService();

    //Colors
    Color pageColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);
    Color incorrectColor = const Color.fromARGB(255, 241, 46, 46);
    Color correctColor = const Color.fromARGB(255, 46, 241, 88);
    Color resultColor = const Color(0xFFFEFFD9);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    List<bool> ignoreFirstValue = widget.tappedImages.sublist(1);

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: [
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
          Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: ListView.builder(
              // Incorrect use of ParentDataWidget.
              itemCount: widget.shownImages.length,
              itemBuilder: (context, index) {
                if(widget.mode == "mode1".tr){
                if (widget.shownImages[index] == widget.stimuli) {
                  if (ignoreFirstValue[index] == true) {
                    resultColor = correctColor;
                  } else {
                    resultColor = incorrectColor;
                  }
                }else{
                   if (ignoreFirstValue[index] == false) {
                    resultColor = correctColor;
                  } else {
                    resultColor = incorrectColor;
                  }
                }}else{
                  if (widget.shownImages[index] == widget.stimuli) {
                  if (ignoreFirstValue[index] == true) {
                    resultColor = incorrectColor;
                  } else {
                    resultColor = correctColor;
                  }
                }else{
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
                        ignoreFirstValue, widget.shownImages);
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const EndGamePage();
                      }),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
