import 'package:animattio_mobile_app/pages/before_game/mode_page.dart';
import 'package:animattio_mobile_app/pages/user_pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    //Strings
    String themeTitle = "choose_theme".tr;
    String chosenTheme = "";

    //Colors
    Color pageColor = const Color(0xFFF7A559);
    Color titleColor = const Color(0xFFFEFFD9);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                 SizedBox(height: height*0.05),
                Align(
                  alignment: Alignment.topLeft,
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
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/flower_icon.png'),
                  iconSize: 50,
                  onPressed: () {
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
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/animal_icon.png'),
                  iconSize: 50,
                  onPressed: () {
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
                IconButton(
                  icon:
                      Image.asset('assets/theme_page/icons/dinosaur_icon.png'),
                  iconSize: 50,
                  onPressed: () {
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
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/car_icon.png'),
                  iconSize: 50,
                  onPressed: () {
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
