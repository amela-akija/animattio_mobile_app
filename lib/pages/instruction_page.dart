import 'dart:math';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InstructionPage extends StatefulWidget {
  String chosenMode;
  String chosenTheme;
  InstructionPage({super.key, required this.chosenMode, required this.chosenTheme});

  @override
  State<InstructionPage> createState() => _InstructionPageState();
}

class _InstructionPageState extends State<InstructionPage> {

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



  @override
  Widget build(BuildContext context) {

     //Strings
    String instructionMode1 = "React by clicking on the screen only when this symbol is displayed";
    String instructionMode2 = "React by clicking on the screen only when this symbol is NOT displayed";

    //Colors
    Color pageColor = const Color(0xFFFEFFD9);
    Color textColor = const Color(0xFFF7A559);

    Random random = Random();
    int randomIndex = random.nextInt(listOfAnimals.length);
    String stimuli = listOfAnimals[randomIndex];

    return Scaffold(
      backgroundColor: pageColor,
      body:  Column(
        children: [
          Builder(builder: (context){
            if(widget.chosenMode == "Click on the screen only when given symbol is displayed"){
              return    Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                      instructionMode1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 32,
                        fontFamily: 'Lilita One',
                      ),
                    ),
              );
            }else{
              return  Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                      instructionMode2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: textColor,
                        fontSize: 32,
                        fontFamily: 'Lilita One',
                      ),
                    ),
              );
            }
          }),
          Center(
             child: Image.asset(stimuli,
              ),
          )
        ],
      ),

      );

        
       
      
  }
}