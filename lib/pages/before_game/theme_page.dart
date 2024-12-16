import 'package:animattio_mobile_app/pages/before_game/mode_page.dart';
import 'package:animattio_mobile_app/pages/user_pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// ThemePage is a page where user chooses in which theme the game should be played.
///
/// This page contains 4 buttons, each for one of the available themes: animal, flower, dinosaur and car.
///
class ThemePage extends StatelessWidget {
  /// Creates a [ThemePage].
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    ///Strings used on page.
    String themeTitle = "choose_theme".tr;
    String chosenTheme = "";

    /// Color definitions used throughout the page.
    Color pageColor = const Color(0xFFF7A559);
    Color titleColor = const Color(0xFFFEFFD9);

    ///Size of the screen used for a responsive ui.
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    /// Main UI of the page composed of multiple stacked elements.
    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: height * 0.05),
                Align(
                  alignment: Alignment.topLeft,
                  //Button that allows user to go back to UserPage
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    color: titleColor,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const UserPage();
                      }));
                    },
                  ),
                ),
                //Title of the page
                Text(
                  themeTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 56,
                    fontFamily: 'Lilita One',
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: height * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Button for flower theme
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/flower_icon.png'),
                  iconSize: 50,
                  onPressed: () {
                    //navigates to ModePage

                    chosenTheme = "flower";
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ModePage(
                              chosenTheme: chosenTheme,
                            )));
                  },
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                //Button for animal theme
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/animal_icon.png'),
                  iconSize: 50,
                  onPressed: () {
                    //navigates to ModePage

                    chosenTheme = "animal";
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ModePage(
                              chosenTheme: chosenTheme,
                            )));
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: height * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Button for dinosaur theme
                IconButton(
                  icon:
                      Image.asset('assets/theme_page/icons/dinosaur_icon.png'),
                  iconSize: 50,
                  onPressed: () {
                    //navigates to ModePage

                    chosenTheme = "dinosaur";
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ModePage(
                              chosenTheme: chosenTheme,
                            )));
                  },
                ),
                SizedBox(
                  width: width * 0.05,
                ),
                //Button for car theme
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/car_icon.png'),
                  iconSize: 50,
                  onPressed: () {
                    //navigates to ModePage
                    chosenTheme = "car";
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ModePage(
                              chosenTheme: chosenTheme,
                            )));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
