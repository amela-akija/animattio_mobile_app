import 'package:animattio_mobile_app/pages/authentication/main_page.dart';
import 'package:animattio_mobile_app/pages/user_pages/user_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final dbService = DatabaseService();
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    Map<String, String> userData = await dbService.getUserData();
    usernameController.text = userData['username'] ?? '';
    emailController.text = userData['email'] ?? '';
  }

  //Registration controllers
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Strings
    String pageTitle = "update".tr;

    //Colors
    Color buttonColor = const Color(0xFFF7A559);
    Color textColor = const Color(0xFF2A470C);
    Color pageColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);
    Color inputColor = const Color(0xFFFEFFD9);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: pageColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Stack(
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
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        pageTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 56,
                          fontFamily: 'Lilita One',
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: deviceSize.height * 0.22,
                    left: 0,
                    right: 0,
                    child: Text(
                      "enter_new_username".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 12,
                        fontFamily: 'Fredoka',
                      ),
                    ),
                  ),
                  Positioned(
                    top: deviceSize.height * 0.25,
                    width: deviceSize.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: usernameController,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: inputColor,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: inputColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: inputColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: inputColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return null;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                   Positioned(
                    top: deviceSize.height * 0.37,
                    left: 0,
                    right: 0,
                    child: Text(
                      "enter_new_email".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 12,
                        fontFamily: 'Fredoka',
                      ),
                    ),
                  ),
                  Positioned(
                    top: deviceSize.height * 0.40,
                    width: deviceSize.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: emailController,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: inputColor,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: inputColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: inputColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: inputColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return null;
                            } else if (!value.contains("@")) {
                              return "email_format".tr;
                            }
                            return null; //zmiana
                          },
                        ),
                      ),
                    ),
                  ),
                   Positioned(
                    top: deviceSize.height * 0.52,
                    left: 0,
                    right: 0,
                    child: Text(
                      "enter_new_password".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 12,
                        fontFamily: 'Fredoka',
                      ),
                    ),
                  ),
                  Positioned(
                    top: deviceSize.height * 0.55,
                    width: deviceSize.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: inputColor,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: inputColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: inputColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: inputColor),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return null;
                            } else if (value.length < 8) {
                              return "short_password".tr;
                            } else if (!value.contains(RegExp(r'[A-Z]'))) {
                              return "uppercase".tr;
                            } else if (!value.contains(RegExp(r'[0-9]'))) {
                              return "numerical".tr;
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                        ),
                      ),
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
                          onPressed: () async {
                            FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                            User? currentUser = firebaseAuth.currentUser;
                             if (passwordController.text != '' && emailController.text != currentUser?.email) {
                              dbService.updateUserData(usernameController.text,
                                  emailController.text);
                              currentUser
                                  ?.updatePassword(passwordController.text);
                              currentUser?.verifyBeforeUpdateEmail(
                                  emailController.text);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return MainPage();
                              }));
                              await FirebaseAuth.instance.signOut();
                            }
                            else if (emailController.text != currentUser?.email) {
                              dbService.updateUserData(usernameController.text,
                                  emailController.text);
                              currentUser?.verifyBeforeUpdateEmail(
                                  emailController.text);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return MainPage();
                              }));
                              await FirebaseAuth.instance.signOut();
                            } else if (passwordController.text != '') {
                              dbService.updateUserData(usernameController.text,
                                  emailController.text);
                              currentUser
                                  ?.updatePassword(passwordController.text);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return MainPage();
                              }));
                              await FirebaseAuth.instance.signOut();
                            } 
                            
                            else {
                              dbService.updateUserData(usernameController.text,
                                  emailController.text);
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const UserPage();
                              }));
                            }
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
