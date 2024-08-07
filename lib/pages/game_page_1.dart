import 'dart:async';

import 'package:flutter/material.dart';

class GamePage1 extends StatefulWidget {
  final String stimuli;
  final List<String> listOfImages;
  const GamePage1({super.key,required this. stimuli, required this.listOfImages});

  @override
  _GamePage1State createState() => _GamePage1State();
}

class _GamePage1State extends State<GamePage1> {
  int currentImage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      setState(() {
        _shuffleImages();
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }



  void _shuffleImages() {
    //show random images
    setState(() {
      currentImage = (currentImage + 1) %
          widget.listOfImages.length; 
    });
  }

 

  @override
  Widget build(BuildContext context) {
    //Colors
    Color pageColor = const Color(0xFFFEFFD9);

    return GestureDetector(
      child: Scaffold(
        backgroundColor: pageColor,
        body: Center(
          child: 
          Image.asset(widget.listOfImages[currentImage]),

        ),
      ),
    );
  }
}
