import 'package:animattio_mobile_app/avatar_page.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    String userTitle = "My profile";
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);
    Color titleColor = const Color(0xFF2A470C);

    double buttonWidth = MediaQuery.of(context).size.width * 0.8;

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/user_page/star_user_3.png',
            ),
          ),
          Positioned(
            left: 0,
            child: Transform.translate(
              offset: Offset(0, 80),
              child: Transform.scale(
                scale: 1,
                child: Image.asset(
                  'assets/user_page/star_user_2.png',
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            child: Transform.translate(
              offset: Offset(0, 125),
              child: Transform.scale(
                scale: 1,
                child: Image.asset(
                  'assets/user_page/star_user_1.png',
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30), 
                Text(
                  userTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 60,
                    fontFamily: 'Lilita One',
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.5), 
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const AvatarPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 25,
                          fontFamily: 'Lilita One',
                          fontWeight: FontWeight.w900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      'change avatar',
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const UserPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 25,
                          fontFamily: 'Lilita One',
                          fontWeight: FontWeight.w900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      'play game',
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: buttonWidth,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const UserPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 15),
                      textStyle: const TextStyle(
                          fontSize: 25,
                          fontFamily: 'Lilita One',
                          fontWeight: FontWeight.w900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      'settings',
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
