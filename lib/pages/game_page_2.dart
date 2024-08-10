import 'dart:async';
import 'dart:math';

import 'package:animattio_mobile_app/pages/end_game_page.dart';
import 'package:animattio_mobile_app/pages/result_page.dart';
import 'package:flutter/material.dart';

class GamePage2 extends StatefulWidget {
  final int stimuliIndex;
  final List<String> listOfImages;
  const GamePage2(
      {super.key, required this.stimuliIndex, required this.listOfImages});
  @override
  // ignore: library_private_types_in_public_api
  _GamePage2State createState() => _GamePage2State();
}

class _GamePage2State extends State<GamePage2> {
  //images
  int currentImageIndex = 0;
  int previousImageIndex = 0;

  List<int> shownImagesIndexes = [];
  List<bool> tappedImages = [];

//timers
  late Timer showImageTimer;
  late Timer hideImageTimer;

  //state of displayed image
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    showAndHideImage();
  }

  void showAndHideImage() {
    showImageTimer = Timer.periodic(Duration(milliseconds: 250), (timer) {
      showRandomImage();
    });

    hideImageTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      hideRandomImage();
    });
  }

  void showRandomImage() {
    // showImageTimer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
    Random random = Random();
    setState(() {
      currentImageIndex = random.nextInt(widget.listOfImages.length);
      shownImagesIndexes.add(currentImageIndex);
      isVisible = false;
    });
    // });
  }

  void hideRandomImage() {
    // Future.delayed(const Duration(seconds: 2), () {
    if (this.mounted) {
      setState(() {
        isVisible = true;
      });
    }
    // });
  }

  @override
  void dispose() {
    showImageTimer.cancel();
    hideImageTimer.cancel();
    super.dispose();
  }

  // void screenTap(int currentIndex) {
  //   setState(() {
  //     tappedImages[currentIndex] = true;
  //   });
  // }
  void screenTap(){
    
  }


 @override
  Widget build(BuildContext context) {
    //Colors
    Color pageColor = const Color(0xFFFEFFD9);
    return GestureDetector(
      onTap: screenTap,
      child: Scaffold(
        backgroundColor: pageColor,
        body: Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: isVisible,
          child: Center(
            child: Image.asset(widget.listOfImages[currentImageIndex]),
          ),
        ),
      ),
    );


  }
}
