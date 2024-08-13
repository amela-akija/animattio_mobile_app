import 'dart:async';
import 'dart:math';

import 'package:animattio_mobile_app/pages/result_page.dart';
import 'package:flutter/material.dart';

class GamePage1 extends StatefulWidget {
  final String stimuli;
  final List<String> listOfImages;
  const GamePage1({super.key,required this. stimuli, required this.listOfImages});

  @override
  _GamePage1State createState() => _GamePage1State();
}

class _GamePage1State extends State<GamePage1> {
  Random random = Random();
  String? currentImage;
  List<String> shownImages = [];
  int count = 0;

   Timer? displayTimer;
  Timer? hideTimer;


   @override
  void initState() {
    super.initState();
    startGame();
  }

    void startGame() {
    displayTimer = Timer.periodic(Duration(milliseconds: 2250), (timer) {
      if (count >= 20) {
        timer.cancel();
         Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return ResultPage(shownImages: [], tappedImages: const [],
                );
              }),
            );
      } else {
        setState(() {
          currentImage = widget.listOfImages[random.nextInt(widget.listOfImages.length)];
          shownImages.add(currentImage!);
          // ignore: avoid_print
          print("Images shown ${shownImages.length}");
          count++;
        });

        hideTimer = Timer(Duration(milliseconds: 250), () {
          setState(() {
            currentImage = null;
          });
        });
      }
    });
  }

   @override
  void dispose() {
    displayTimer?.cancel();
    hideTimer?.cancel();
    super.dispose();
  }

 

  @override
  Widget build(BuildContext context) {
    //Colors
    Color pageColor = const Color(0xFFFEFFD9);

    return GestureDetector(
      child: Scaffold(
        backgroundColor: pageColor,
        body: Center(
        child: currentImage != null
            ? Image.asset(currentImage!)
            : const SizedBox(),
      ),
      ),
    );
  }
}
