import 'package:flutter/material.dart';

/// [ImagesProvider] is a class that provides the app with list of images basen on chosen theme.
///
/// It contains of a map of 4 lists, one for each theme and consisting of available symbols within the theme.
///
class ImagesProvider with ChangeNotifier {
  Map<String, List<String>> listsOfThemes = {
    'animal': [
      'assets/themes/animal_theme/animal1.png',
      'assets/themes/animal_theme/animal2.png',
      'assets/themes/animal_theme/animal3.png',
      'assets/themes/animal_theme/animal4.png',
      'assets/themes/animal_theme/animal5.png',
      'assets/themes/animal_theme/animal6.png',
      'assets/themes/animal_theme/animal7.png',
      'assets/themes/animal_theme/animal8.png',
      'assets/themes/animal_theme/animal9.png',
      'assets/themes/animal_theme/animal10.png',
      'assets/themes/animal_theme/animal11.png',
      'assets/themes/animal_theme/animal12.png',
      'assets/themes/animal_theme/animal13.png',
      'assets/themes/animal_theme/animal14.png',
      'assets/themes/animal_theme/animal15.png',
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
      'assets/themes/dinosaur_theme/dinosaur5.png',
      'assets/themes/dinosaur_theme/dinosaur5.png',
      'assets/themes/dinosaur_theme/dinosaur6.png',
      'assets/themes/dinosaur_theme/dinosaur7.png',
      'assets/themes/dinosaur_theme/dinosaur8.png',
      'assets/themes/dinosaur_theme/dinosaur9.png',
      'assets/themes/dinosaur_theme/dinosaur10.png',
    ],
  };

  /// [getList] provides a list from available lists.
  ///
  /// The [getList] method searches for a list of images associated with provided key [listName].
  /// If the list is found, it returns the corresponding list; otherwise, it returns an empty list.
  ///
  /// - [listName]: The key (name) of the list to be retrieved from [listsOfThemes].
  ///
  /// Returns:
  /// - A [List<String>] containing the symbols from theme [listName], or an empty list if
  ///   the specified list does not exist.
  ///
  List<String> getList(String listName) {
    return listsOfThemes[listName] ?? [];
  }

  /// [setList] updates or sets a list of images in the [listsOfThemes] collection.
  ///
  /// The [setList] method updates the [listsOfThemes] map by associating the key [listName]
  /// with the provided [list]. It also informs listeners with notifyListeners that the data was modified.
  ///
  /// - [listName]: The key to connect with the list of images.
  /// - [list]: The new list of images to be set for the specified key [listName].
  ///
  void setList(String listName, List<String> list) {
    listsOfThemes[listName] = list;
    notifyListeners();
  }
}
