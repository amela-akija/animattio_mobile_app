import 'package:animattio_mobile_app/pages/authentication/login_page.dart';
import 'package:animattio_mobile_app/services/auth_service.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// SignupPage is the page where user can register.
///
/// This page contains of a register form: 4 TextFormFields for email, username, and two inputs for password.
/// The layout includes button that when pressed navigates to LoginPage if the registration proccess
/// was correct. It also includes decorative images positioned
/// around the screen and a TextButton that navigates to LoginPage.
///
class SignupPage extends StatefulWidget {
  /// Creates a [SignupPage].
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  /// Instance of [DatabaseService].
  final dbService = DatabaseService();

  /// A [GlobalKey] that uniquely identifies the [FormState] of a form widget.
  ///
  /// The [_formKey] is used to validate inputs and save form data while pressing assigned button.
  ///
  final GlobalKey<FormState> _formKey = GlobalKey();

  /// Controllers for the email, username and password input fields.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  /// Default avatar when no avatar was chosen.
  final String avatar = 'assets/user_page/no_avatar.png';

  /// Default role fo this app.
  final String role = "patient";

  /// Boolean flag that indicates if loading sign should be shown.
  bool showLoading = false;

  @override
  void dispose() {
    // Disposes of the controllers when the widget is removed from the widget tree.
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size of the screen used for a responsive ui.
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    // Color definitions used throughout the page.
    Color fontColor = const Color(0xFFFEFFD9);
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFF7A559);
    Color inputColor = const Color(0xFFFEFFD9);
    Color textColor = const Color(0xFF2A470C);

    ///Strings used on page.
    String signUpTitle = "sign_up".tr;
    String toLogInString = "sign_to_log".tr;
    // Main UI of the page composed of multiple stacked elements in Form container.
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // for images to not move when keyboard is active
      backgroundColor: pageColor,
      body:
          //Registration form
          Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Stack(
                children: <Widget>[
                  //Image displayed in the background (star_login)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: width,
                      height: height * 0.3,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.asset('assets/login_page/star_login.png'),
                      ),
                    ),
                  ),
                  //Title of the page
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.05),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Text(
                        signUpTitle,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: fontColor,
                          fontSize: 60,
                          fontFamily: 'Lilita One',
                        ),
                      ),
                    ),
                  ),
                  //Username text input
                  Positioned(
                    top: deviceSize.height * 0.2,
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
                            hintText: 'enter_username'.tr,
                            hintStyle: TextStyle(
                                color: textColor, fontFamily: 'Fredoka'),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "fields".tr;
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  //Email text input
                  Positioned(
                    top: deviceSize.height * 0.32,
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
                            hintText: 'enter_email'.tr,
                            hintStyle: TextStyle(
                                color: textColor, fontFamily: 'Lilita One'),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          validator: (value) {
                            ///Validation rules: field cannot be empty and must contain special character @.
                            if (value!.isEmpty) {
                              return "fields".tr;
                            } else if (!value.contains("@")) {
                              return "email_format".tr;
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  //Password text input
                  Positioned(
                    top: deviceSize.height * 0.44,
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
                            hintText: 'enter_password'.tr,
                            hintStyle: TextStyle(
                                color: textColor, fontFamily: 'Lilita One'),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          validator: (value) {
                            ///Validation rules: field cannot be empty, it must contain one capital letter, one number
                            ///and the length must be above 8 characters.
                            if (value!.isEmpty) {
                              return "fields".tr;
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
                          obscureText: true, //hides the characters
                        ),
                      ),
                    ),
                  ),
                  //Second password text input
                  Positioned(
                    top: deviceSize.height * 0.56,
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
                          controller: repeatPasswordController,
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
                            hintText: 'repeat_password'.tr,
                            hintStyle: TextStyle(
                                color: textColor, fontFamily: 'Lilita One'),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                          validator: (value) {
                            ///Validation rules: field cannot be empty and it must be the same value as provided in the first password TextFormField.
                            if (value!.isEmpty) {
                              return "fields".tr;
                            } else if (value != passwordController.text) {
                              return "password_match".tr;
                            } else {
                              return null;
                            }
                          },
                          obscureText: true,
                        ),
                      ),
                    ),
                  ),
                  //Button that registers the user if the form was correctly filled
                  Positioned(
                    top: deviceSize.height * 0.75,
                    width: deviceSize.width,
                    child: Center(
                      child: ElevatedButton(
                        //When pressed validates the submitted data and registers user or show error messages
                        onPressed: () async {
                          // Check if username is unique
                          bool uniqueUsername =
                              await DatabaseService.checkIfUsernameExists(
                                  usernameController.text);

                          if (uniqueUsername) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text("username_found".tr)),
                            );
                            return;
                          }
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              //show loading symbol while processing the data
                              showLoading = true;
                            });
                            await AuthServices().registerUser(
                                emailController.text,
                                passwordController.text,
                                usernameController.text,
                                avatar,
                                role,
                                context);
                            setState(() {
                              //hide loading symbol when registration is complete
                              showLoading = false;
                            });

                            emailController.clear();
                            passwordController.clear();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) {
                              return const LoginPage();
                            }));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
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
                        child: showLoading
                            ? const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator())
                            : Text(
                                signUpTitle,
                                style: TextStyle(color: fontColor),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //Button when pressed navigates to LoginPage
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const LoginPage();
                    }));
                  },
                  child: Text(
                    toLogInString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18,
                      fontFamily: 'Fredoka',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// [RegisteredUser] is a class which objects represent registered user of the app.
///
/// It contains basic information about the user, including their username, email address, default role
/// and their chosen avatar image.
class RegisteredUser {
  ///Username provided in registration.
  final String username;

  // Default avatar - the user can later choose from AvatarPage.
  final String avatar;
  // Default role patient;
  final String role;

  /// Creates a [RegisteredUser] instance with provided [username], [role] and [avatar].
  ///
  /// All fields are required and must be provided when creating a new instance of [RegisteredUser].
  RegisteredUser(
      {required this.username, required this.avatar, required this.role});

  /// Converts the [RegisteredUser] instance into a map
  ///
  /// Returns a map with keys corresponding to
  /// the user's data.
  Map<String, dynamic> toMap() =>
      {"username": username, "avatar": avatar, "role": role};
}
