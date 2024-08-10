import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GamePage2 extends StatefulWidget {
  final String stimuli;
  final List<String> listOfImages;
  const GamePage2(
      {super.key, required this.stimuli, required this.listOfImages});
  @override
  // ignore: library_private_types_in_public_api
  _GamePage2State createState() => _GamePage2State();
}

class _GamePage2State extends State<GamePage2> {
  int currentImageIndex = 0;
  int previousImageIndex = 0;

  late Timer showImageTimer;
  late Timer hideImageTimer;
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    showAndHideImage();
    // showRandomImage();
    // hideRandomImage();
  }

  void showAndHideImage(){
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

  void screenTap() {}
  // bool showImage = true;
  // int currentImage = 0;
  // int previousImage = 0;
  // late Timer imageTimer;
  // late Timer hideImageTimer;
  // List<String> score = [];
  // List<String> shownImages = [];

  // void _startImageDisplay() {
  //   imageTimer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
  //     setState(() {
  //       showImage = true;
  //     });
  //     hideImageTimer = Timer(const Duration(seconds: 3), () {
  //       setState(() {
  //         currentImage = (currentImage + 1) % widget.listOfImages.length;
  //         previousImage = currentImage;
  //         shownImages.add(widget.listOfImages[previousImage]);
  //         showImage = false;
  //       });
  //     });
  //   });
  // }
  // void _screenTap(){
  //   if(widget.listOfImages[previousImage] == widget.stimuli){
  //     score.add("f");

  //   }else if(widget.listOfImages[previousImage] != widget.stimuli){
  //     score.add("h");
  //   }
  // }

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

    // return GestureDetector(
    //   onTap: _screenTap,
    //   child: Scaffold(
    //     backgroundColor: pageColor,
    //     body: Builder(
    //       builder: (context) {
    //         if(shownImages.length<5){
    //         return Center(
    //           child: showImage
    //               ? Image.asset(widget.listOfImages[currentImage])
    //               : const SizedBox.shrink(),
    //         );}
    //         else{
    //           return Text(score.join(","));
    //         }
    //       }
    //     ),
    //   ),
    // );
  }
}
