import 'package:flutter/material.dart';
import 'login_page.dart';
import 'signup_page.dart';
 // Main page from which user can choose either to log in or to sign up
class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFF7A559);
    Color fontColor = const Color(0xFFFEFFD9);
    return  Scaffold(
        backgroundColor: pageColor,
        body: Stack(
          children: <Widget>[
            Center(
              child: Image.asset(
                'assets/logos/logo.png',
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/main_page/star_main_2.png',
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Image.asset(
                'assets/main_page/star_main_1.png',
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/main_page/star_main_4.png',
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: Image.asset(
                'assets/main_page/star_main_3.png',
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.74,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {return const LoginPage();}));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 45, vertical: 15),
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
                    'Log in',
                    style: TextStyle(color: fontColor),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.83,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: ElevatedButton(
                  onPressed: () { Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {return const SignupPage();}));},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 37, vertical: 15),
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
                    'Sign up',
                    style: TextStyle(color: fontColor),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
  }
}