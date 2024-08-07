import 'dart:async';

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
  bool showImage = true;
  int currentImage = 0;
  int previousImage = 0;
  late Timer imageTimer;
  late Timer hideImageTimer;
  List<String> score = [];
  List<String> shownImages = [];

  @override
  void initState() {
    super.initState();
    _startImageDisplay();
  }

  void _startImageDisplay() {
    imageTimer = Timer.periodic(const Duration(seconds: 7), (Timer timer) {
      setState(() {
        showImage = true;
      });
      hideImageTimer = Timer(const Duration(seconds: 3), () {
        setState(() {
          currentImage = (currentImage + 1) % widget.listOfImages.length;
          previousImage = currentImage;
          shownImages.add(widget.listOfImages[previousImage]);
          showImage = false;
        });
      });
    });
  }
  void _screenTap(){
    if(widget.listOfImages[previousImage] == widget.stimuli){
      score.add("f");

    }else if(widget.listOfImages[previousImage] != widget.stimuli){
      score.add("h");
    }
  }

  @override
  void dispose() {
    imageTimer.cancel();
    hideImageTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Colors
    Color pageColor = const Color(0xFFFEFFD9);

    return GestureDetector(
      onTap: _screenTap,
      child: Scaffold(
        backgroundColor: pageColor,
        body: Builder(
          builder: (context) {
            if(shownImages.length<5){
            return Center(
              child: showImage
                  ? Image.asset(widget.listOfImages[currentImage])
                  : const SizedBox.shrink(),
            );}
            else{
              return Text(score.join(","));
            }
          }
        ),
      ),
    );
  }
}
