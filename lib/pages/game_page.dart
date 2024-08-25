import 'dart:async';
import 'dart:math';

import 'package:animattio_mobile_app/pages/result_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  final String stimuli;
  final List<String> listOfImages;
  final String mode;
  const GamePage({super.key,required this. stimuli, required this.listOfImages, required this.mode});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Random random = Random();
  String? currentImage;
  List<String> shownImages = [];
  List<bool> tappedImages = [];
  int count = 0;
  int imageIndex = 0;
  int lastIndex = 0;

  Timer? showTimer;
  Timer? hideTimer;

   @override
  void initState() {
    super.initState();
    tappedImages = List.filled(21, false); //TODO: check length
    startGame();
  }

    void startGame() {
    showTimer = Timer.periodic(const Duration(milliseconds: 2250), (timer) { //TODO: add different intervals
      if (count >= 20) {
        timer.cancel();
         Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return ResultPage(shownImages: shownImages, tappedImages: tappedImages, stimuli: widget.stimuli, mode: widget.mode,
                );
              }),
            );
      } else {
        setState(() {
          currentImage = widget.listOfImages[random.nextInt(widget.listOfImages.length)];

          shownImages.add(currentImage!);
          lastIndex++;
          // ignore: avoid_print
          print("Images shown ${shownImages.length}");
          count++;
        });

        hideTimer = Timer(const Duration(milliseconds: 250), () {
          setState(() {
            currentImage = null;
          });
        });
      }
    });
  }

  void tappedImage(){
            tappedImages[lastIndex] = true;
            // ignore: avoid_print
            print("Tapped image $lastIndex");
  }


   @override
  void dispose() {
    showTimer?.cancel();
    hideTimer?.cancel();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    //Colors
    Color pageColor = const Color(0xFFFEFFD9);
    return Scaffold(
      backgroundColor: pageColor,
      body: GestureDetector(
         onTap: () => tappedImage(),
        child: Center(
        child: currentImage != null
            ? Image.asset(currentImage!)
             : Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
              ),
              ),
      ),
    );
  }
}
