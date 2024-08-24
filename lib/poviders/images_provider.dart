import 'package:flutter/material.dart';

class ImagesProvider with ChangeNotifier {
  Map<String, List<String>> listsOfThemes = {
    'animal': [
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
    ],
    'flower': [
      'assets/themes/flower_theme/flower1.png',
      'assets/themes/flower_theme/flower2.png',
      'assets/themes/flower_theme/flower3.png',
      'assets/themes/flower_theme/flower4.png',
      'assets/themes/flower_theme/flower5.png',
      'assets/themes/flower_theme/flower6.png',
      'assets/themes/flower_theme/flower7.png',
      'assets/themes/flower_theme/flower8.png',
      'assets/themes/flower_theme/flower9.png',
      'assets/themes/flower_theme/flower10.png',
      'assets/themes/flower_theme/flower11.png',
      'assets/themes/flower_theme/flower12.png',
      'assets/themes/flower_theme/flower13.png',
      'assets/themes/flower_theme/flower14.png',
      'assets/themes/flower_theme/flower15.png',
    ],
    'car': [
      'assets/themes/car_theme/car1.png',
      'assets/themes/car_theme/car2.png',
      'assets/themes/car_theme/car3.png',
      'assets/themes/car_theme/car4.png',
      'assets/themes/car_theme/car5.png',
      'assets/themes/car_theme/car6.png',
      'assets/themes/car_theme/car7.png',
      'assets/themes/car_theme/car8.png',
      'assets/themes/car_theme/car9.png',
      'assets/themes/car_theme/car10.png',
      'assets/themes/car_theme/car11.png',
      'assets/themes/car_theme/car12.png',
      'assets/themes/car_theme/car13.png',
      'assets/themes/car_theme/car14.png',
      'assets/themes/car_theme/car15.png',
      
    ],
    'dinosaur': [
      'assets/themes/dinosaur_theme/dinosaur1.png',
      'assets/themes/dinosaur_theme/dinosaur2.png',
      'assets/themes/dinosaur_theme/dinosaur3.png',
      'assets/themes/dinosaur_theme/dinosaur4.png',
      'assets/themes/dinosaur_theme/dinosaur5.jpg',
    ],
  };

  List<String> getList(String listName) {
    return listsOfThemes[listName] ?? [];
  }

  void setList(String listName, List<String> list) {
    listsOfThemes[listName] = list;
    notifyListeners();
  }
}
