import 'package:animattio_mobile_app/controllers/locale_controller.dart';
import 'package:animattio_mobile_app/pages/user_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  final LocaleController localeController = Get.put(LocaleController());

   SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
    @override
  Widget build(BuildContext context) {
    
    //Strings
    String pageTitle = "settings".tr;
    String chooseButton = "Choose";


    //Colors
    Color buttonColor = const Color(0xFF2A470C);
    Color chooseColor = const Color(0xFFFEFFD9);
    Color pageColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: SizedBox(
              width: width * 0.5,
              height: height * 0.5,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  'assets/avatar_page/star_avatar_1.png',
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: SizedBox(
              width: width * 0.6,
              height: height * 0.5,
              child: FittedBox(
                fit: BoxFit.cover,
                child: Image.asset(
                  'assets/avatar_page/star_avatar_2.png',
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 30),
                Text(
                  pageTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: chooseColor,
                    fontSize: 56,
                    fontFamily: 'Lilita One',
                  ),
                ),

                 Positioned(
            width: deviceSize.width,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                   onPressed: () {
                     widget.localeController.swapLanguages();
          },

                  style: TextButton.styleFrom(
                    backgroundColor: fontColor,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    textStyle: const TextStyle(
                        fontSize: 25,
                        fontFamily: 'Fredoka',
                        fontWeight: FontWeight.w900),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                  ),
                  child: Text(
                   widget.localeController.currentLocale.value.languageCode == 'en' ? 'PL_switch'.tr : 'EN_switch'.tr,
                style: TextStyle(color: buttonColor),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
           Positioned(
            width: deviceSize.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                   onPressed: () {
                    Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const UserPage();
                  }));
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
                    elevation: 10,
                  ),
                  child: Text(
                  "save".tr,
                style: TextStyle(color: buttonColor),
                  ),
                ),
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
