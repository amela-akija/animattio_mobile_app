import 'dart:async';

import 'package:flutter/material.dart';

class GamePage1 extends StatefulWidget {
  const GamePage1({super.key});

  @override
  _GamePage1State createState() => _GamePage1State();
}

class _GamePage1State extends State<GamePage1> {
  final List<String> listOfAnimals = [
    'assets/themes/animal_theme/animal1.png',
    'assets/themes/animal_theme/animal2.png',
    'assets/themes/animal_theme/animal3.png',
    'assets/themes/animal_theme/animal4.png',
    'assets/themes/animal_theme/animal5.png',
    'assets/themes/animal_theme/animal6.avif',
    // 'assets/themes/animal_theme/animal7.png',
    'assets/themes/animal_theme/animal8.png',
    'assets/themes/animal_theme/animal9.png',
    'assets/themes/animal_theme/animal10.png',
  ];
   final List<String> listOfFlowers = [
    'assets/themes/flower_theme/flower1.png',
    'assets/themes/flower_theme/flower2.png',
    'assets/themes/flower_theme/flower3.png',
    'assets/themes/flower_theme/flower4.png',
    'assets/themes/flower_theme/flower5.png',
  ];
   final List<String> listOfCars = [
    'assets/themes/car_theme/car1.png',
    'assets/themes/car_theme/car2.png',
    'assets/themes/car_theme/car3.png',
    'assets/themes/car_theme/car4.png',
    'assets/themes/car_theme/car5.png',
  ];

    final List<String> listOfDinosaurs = [
    'assets/themes/dinosaur_theme/dinosaur1.png',
    'assets/themes/dinosaur_theme/dinosaur2.png',
    'assets/themes/dinosaur_theme/dinosaur3.png',
    'assets/themes/dinosaur_theme/dinosaur4.png',
    'assets/themes/dinosaur_theme/dinosaur5.png',
  ];

  int currentImage = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
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

  void _timeRestart() {
    //after tap restart timer
    timer?.cancel();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _shuffleImages();
      });
    });
  }

  void _shuffleImages() {
    //show random images
    setState(() {
      currentImage = (currentImage + 1) %
          listOfAnimals.length; // TODO: make the list general
    });
  }

  void _tapScreen() {
    //combine both actions
    _shuffleImages();
    _timeRestart();
  }

  @override
  Widget build(BuildContext context) {
    //Colors
    Color pageColor = const Color(0xFFFEFFD9);

    return GestureDetector(
      onTap: _tapScreen,
      child: Scaffold(
        backgroundColor: pageColor,
        body: Center(
          child: Image.asset(listOfAnimals[currentImage]),
        ),
      ),
    );
  }
}
