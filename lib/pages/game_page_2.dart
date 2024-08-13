import 'dart:async';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GamePage2 extends StatefulWidget {
  final int stimuliIndex;
  final List<String> listOfImages;
  const GamePage2(
      {super.key, required this.stimuliIndex, required this.listOfImages});
  @override
  _GamePage2State createState() => _GamePage2State();
}

class _GamePage2State extends State<GamePage2> {
  //images
  int currentImageIndex = 0;
  int previousImageIndex = 0;
  int countImages = 0;

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
    Random random = Random();
    setState(() {
      currentImageIndex = random.nextInt(widget.listOfImages.length);
      
      isVisible = false;

    });
  }

  void hideRandomImage() {
    if (mounted) {
      setState(() {
        isVisible = true;
      });
    }
  }

  @override
  void dispose() {
    showImageTimer.cancel();
    hideImageTimer.cancel();
    super.dispose();
  }

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