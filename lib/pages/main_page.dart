import 'package:animattio_mobile_app/controllers/locale_controller.dart';
import 'package:animattio_mobile_app/services/localization_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'login_page.dart';
import 'signup_page.dart';

// Main page from which user can choose either to log in or to sign up
class MainPage extends StatelessWidget {
  final LanguageController localeController = Get.put(LanguageController());
  MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    //Colors
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFF7A559);
    Color fontColor = const Color(0xFFFEFFD9);

    //Strings
    String buttonSign = "sign_up".tr;
    String buttonLogin = "log_in".tr;

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
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
              height: height*0.5,
              width: width*0.5,
            ),
          ),
           Positioned(
            width: deviceSize.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.topRight,
                child: TextButton(
                   onPressed: () {
                     localeController.swapLanguages();
          },

                  style: TextButton.styleFrom(
                    backgroundColor: fontColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Lilita One',
                        fontWeight: FontWeight.w900),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                   localeController.currentLocale.value.languageCode == 'en' ? 'PL' : 'EN',
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
