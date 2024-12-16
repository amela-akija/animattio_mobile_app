import 'package:animattio_mobile_app/controllers/locale_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_page.dart';
import 'signup_page.dart';

/// MainPage is the starting point of the app from which the user can choose to either log in or sign up.
///
/// This page contains of two buttons: one for navigating to the login page and another
/// for navigating to the sign-up page. The layout includes decorative images positioned
/// around the screen, a language switcher, and a logo at the center.
/// 
class MainPage extends StatelessWidget {
  /// Instance of [LanguageController] for button that switches languages.
  final LanguageController localeController = Get.put(LanguageController());

  /// Creates a [MainPage].
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Size of the screen used for a responsive ui.
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    // Color definitions used throughout the page.
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFF7A559);
    Color fontColor = const Color(0xFFFEFFD9);

    ///Strings used on page.
    String buttonSign = "sign_up".tr;
    String buttonLogin = "log_in".tr;

    // Main UI of the page composed of multiple stacked elements.
    return Scaffold(
      resizeToAvoidBottomInset:
          false, //for elements to stay in place when keyboard is visible
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          //First image (star_main_2) positioned top right.
          Positioned(
            top: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: width * 0.5,
                height: height * 0.5,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    'assets/main_page/star_main_2.png',
                  ),
                ),
              ),
            ),
          ),
          //Second image (star_main_1) positioned top right on top of first image.

          Positioned(
            top: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                width: width * 0.4,
                height: height * 0.4,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    'assets/main_page/star_main_1.png',
                  ),
                ),
              ),
            ),
          ),
          //Third image (star_main_4) positioned bottom left.

          Positioned(
            bottom: 0,
            left: 0,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: width * 0.45,
                height: height * 0.45,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    'assets/main_page/star_main_4.png',
                  ),
                ),
              ),
            ),
          ),
          //Fourth image (star_main_3) positioned bottom left on top of third image.

          Positioned(
            bottom: 0,
            left: 0,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: SizedBox(
                width: width * 0.35,
                height: height * 0.35,
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.asset(
                    'assets/main_page/star_main_3.png',
                  ),
                ),
              ),
            ),
          ),
          // Elevated button that navigates to LoginPage when pressed.
          Positioned(
            top: deviceSize.height * 0.75,
            width: deviceSize.width,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const LoginPage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                  buttonLogin,
                  style: TextStyle(color: fontColor),
                ),
              ),
            ),
          ),
          // Elevated button that navigates to SignupPage when pressed.

          Positioned(
            top: deviceSize.height * 0.85,
            width: deviceSize.width,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const SignupPage();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                  buttonSign,
                  style: TextStyle(color: fontColor),
                ),
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/logos/logo.png',
              height: height * 0.5,
              width: width * 0.5,
            ),
          ),
          //Button that changes app language when pressed.
          Positioned(
            width: deviceSize.width,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.05),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    localeController.swapLanguages();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: fontColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lilita One',
                        fontWeight: FontWeight.w900),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    localeController.currentLocale.value.languageCode == 'en'
                        ? 'PL'
                        : 'EN',
                    style: TextStyle(color: buttonColor),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
