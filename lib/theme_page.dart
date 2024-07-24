import 'package:animattio_mobile_app/mode_page.dart';
import 'package:animattio_mobile_app/user_page.dart';
import 'package:flutter/material.dart';

class ThemePage extends StatelessWidget {
  const ThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    String themeTitle = "Choose theme";
    Color pageColor = const Color(0xFFF7A559);
    //Color buttonColor = const Color(0xFF2A470C);
    Color titleColor = const Color(0xFFFEFFD9);

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 20,
            left: 0,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: titleColor),
              onPressed: () {
                Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const UserPage();
                      }));
              },
            ),
          ),
          Positioned(
            top: 50,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                themeTitle,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 56,
                  fontFamily: "Lilita One",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            left: 40,
            child: Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/flower_icon.png'),
                  iconSize: 50,
                  onPressed: () {Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ModePage();
                      }));},
                ),
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/animal_icon.png'),
                  iconSize: 50,
                  onPressed: () {Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ModePage();
                      }));},
                ),
              ],
            ),
          ),
          Positioned(
            top: 400,
            left: 40,
            child: Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/dinosaur_icon.png'),
                  iconSize: 50,
                  onPressed: () {Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ModePage();
                      }));},
                ),
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/car_icon.png'),
                  iconSize: 50,
                  onPressed: () {Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ModePage();
                      }));},
                ),
              ],
            ),
          ),
          Positioned(
            top: 550,
            left: 40,
            child: Row(
              children: [
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/shape_icon.png'),
                  iconSize: 50,
                  onPressed: () {Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ModePage();
                      }));},
                ),
                IconButton(
                  icon: Image.asset('assets/theme_page/icons/candy_icon.png'),
                  iconSize: 50,
                  onPressed: () {Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ModePage();
                      }));},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


