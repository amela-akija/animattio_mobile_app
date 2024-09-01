import 'package:animattio_mobile_app/controllers/locale_controller.dart';
import 'package:animattio_mobile_app/pages/edit_profile_page.dart';
import 'package:animattio_mobile_app/pages/main_page.dart';
import 'package:animattio_mobile_app/pages/user_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatefulWidget {
  final LanguageController localeController = Get.put(LanguageController());

  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    //Strings
    String pageTitle = "settings".tr;

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
          Padding(
            padding: const EdgeInsets.only(top:30),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                pageTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: chooseColor,
                  fontSize: 56,
                  fontFamily: 'Lilita One',
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 225),
                SizedBox(
                  width: width * 0.75,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.localeController.swapLanguages();
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: fontColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
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
                      widget.localeController.currentLocale.value
                                  .languageCode ==
                              'en'
                          ? 'PL_switch'.tr
                          : 'EN_switch'.tr,
                      style: TextStyle(color: buttonColor),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: width * 0.75,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const EditProfilePage();
                      }));
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
                      elevation: 10,
                    ),
                    child: Text(
                      "update".tr,
                      style: TextStyle(color: buttonColor),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: width * 0.75,
                  child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return MainPage();
                      }));
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: fontColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
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
                      "log_out".tr,
                      style: TextStyle(color: buttonColor),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: width * 0.75,
                  child: ElevatedButton(
                    onPressed: () async {
                      showAlertDeleteDialog(context);
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: fontColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
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
                      "delete".tr,
                      style: TextStyle(color: buttonColor),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: height * 0.8,
            width: deviceSize.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const UserPage();
                    }));
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
           Positioned(
                left: 0,
                child: Padding(
                padding: EdgeInsets.only(top: height * 0.05),
                  child: Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: chooseColor,
                      iconSize: 30,
                      onPressed: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return const UserPage();
                        },));
                      },
                    ),
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

showAlertDeleteDialog(BuildContext context) {
  Widget noButton = TextButton(
    child: Text("no".tr),
    onPressed: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return MainPage();
      }));
    },
  );
  Widget continueButton = TextButton(
    child: Text("yes".tr),
    onPressed: () async {
      await DatabaseService().moveUserData();
      User? currentUser = FirebaseAuth.instance.currentUser;
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .delete();

      currentUser?.delete();
      await FirebaseAuth.instance.signOut();
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return MainPage();
      }));
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("account_deletion".tr),
    content: Text("delete_info".tr),
    actions: [
      noButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
