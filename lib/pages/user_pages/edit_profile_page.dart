import 'package:animattio_mobile_app/pages/authentication/main_page.dart';
import 'package:animattio_mobile_app/pages/user_pages/user_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// EditProfilePage is the page where user can modify their account data.
///
/// This page contains of the same TextFields as in SignupPage but with user data by default.
/// The layout includes decorative images positioned around the screen and a button to save the changes.
///
class EditProfilePage extends StatefulWidget {
  /// Creates a [EditProfilePage].
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final dbService = DatabaseService();

  /// A [GlobalKey] that uniquely identifies the [FormState] of a form widget.
  ///
  /// The [_formKey] is used to validate inputs and save form data while pressing assigned button.
  ///
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Controllers for email and username inputs.
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  /// [initState] is the first method invoked when the state object is inserted into the widget tree.
  ///
  /// The [initState] method is the first method invoked when the state object is inserted into the widget tree
  /// It is used to call the [loadUserData] method, responsible for filling the input fields with user data from database
  ///
  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  /// Future function [loadUserData] retrieves user data from [DatabaseService].
  ///
  ///It is used to set username and email controllers with values user provided during registration.
  Future<void> loadUserData() async {
    Map<String, String> userData = await dbService.getUserData();
    usernameController.text = userData['username'] ?? '';
    emailController.text = userData['email'] ?? '';
  }

  /// Controller for password inputs.
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ///Strings used on page.
    String pageTitle = "update".tr;

    /// Color definitions used throughout the page.
    Color buttonColor = const Color(0xFFF7A559);
    Color textColor = const Color(0xFF2A470C);
    Color pageColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);
    Color inputColor = const Color(0xFFFEFFD9);

    /// Size of the screen used for a responsive ui.
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;
    /// Main UI of the page composed of form container with multiple stacked elements.
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: pageColor,
      body:
          //Form consisting of 4 input fields similar to SignuPage
          Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: <Widget>[
                  //Image positioned top right (star_avatar_1)
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
                  //Image positioned bottom left (star_avatar_2)
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
                  //Title of the page
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
                  //Username text label
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
                  //Username text input
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
                            ///Validation rule: Field cannot be empty.
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
                  //Email text label
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
                  //Email text input
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
                            ///Validation rules: field cannot be empty and must contain special character @.

                            if (value!.isEmpty) {
                              return null;
                            } else if (!value.contains("@")) {
                              return "email_format".tr;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  //Password text label
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
                  //Password text input
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
                            ///Validation rules: field cannot be empty, it must contain one capital letter, one number
                            ///and the length must be above 8 characters.
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
                  //Button for saving modified data
                  Positioned(
                    top: height * 0.8,
                    width: deviceSize.width,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          onPressed: () async {
                            ///when pressed instance of [FirebaseAuth] is created and
                            /// methods for updating user data are called asynchronously depending on which TextFields were modified
                            ///
                            /// After change in email or password the user is signed out and redirected to MainPage.
                            /// Otherwise the user is navigated to UserPage after changing the data
                            ///
                            FirebaseAuth firebaseAuth = FirebaseAuth.instance;
                            User? currentUser = firebaseAuth.currentUser;
                            if (passwordController.text != '' &&
                                emailController.text != currentUser?.email) {
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
                            } else if (emailController.text !=
                                currentUser?.email) {
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
                            } else {
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
