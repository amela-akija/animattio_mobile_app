import 'package:animattio_mobile_app/pages/user_pages/user_page.dart';
import 'package:animattio_mobile_app/services/auth_service.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'signup_page.dart';

/// LoginPage is the page where already signed up user can log in to their account.
///
/// This page contains of two Textfields: one for email input and another
/// for password input. The layout includes button that when pressed navigates to UserPage if the credentials were correct.
///  It also includesdecorative images positioned
/// around the screen and a TextButton that navigates to SignupPage.
class LoginPage extends StatefulWidget {
  /// Creates a [LoginPage].
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

/// State class for [LoginPage], managing user inputs and UI updates.
class _LoginPageState extends State<LoginPage> {
  /// Controllers for the email and password input fields.
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final dbService = DatabaseService();


  @override
  void dispose() {
    // Disposes of the controllers when the widget is removed from the widget tree.
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Color definitions used throughout the page.
    Color fontColor = const Color(0xFFFEFFD9);
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFF7A559);
    Color inputColor = const Color(0xFFFEFFD9);
    Color textColor = const Color(0xFF2A470C);

    ///Strings used on page.
    String loginTitle = "log_in".tr;
    String toSignUpString = "log_to_sign".tr;

    //Size of the screen used for a responsive ui.
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    // Main UI of the page composed of multiple stacked elements.
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // for images to not move when keyboard is active
      backgroundColor: pageColor,
      body: Column(
        children: <Widget>[
          //Image displayed in the background (star_login)
          Expanded(
            child: Stack(
              children: <Widget>[
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
                      loginTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 60,
                        fontFamily: 'Lilita One',
                      ),
                    ),
                  ),
                ),
                //Email text input
                Positioned(
                  top: deviceSize.height * 0.35,
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
                      child: TextField(
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
                      ),
                    ),
                  ),
                ),
                //Password text input
                Positioned(
                  top: deviceSize.height * 0.50,
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
                      child: TextField(
                        controller: passwordController,
                        style: TextStyle(color: textColor),
                        obscureText: true,
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
                      ),
                    ),
                  ),
                ),
                //Button to authenticate the provided credentials
                Positioned(
                  top: deviceSize.height * 0.7,
                  width: deviceSize.width,
                  child: Center(
                    child: ElevatedButton(
                      //when pressed authenticates the credentials and displays correct message in Snackbar
                      onPressed: () async {
                        await dbService.removeGamesWithoutResult();
                        final message = await AuthServices().loginUser(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        if (message!.contains('login_successfull'.tr)) {
                          await dbService.removeGamesWithoutResult();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const UserPage()));
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(message),
                          ),
                        );
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
                      child: Text(
                        'Log_in'.tr,
                        style: TextStyle(color: fontColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //Button that when clicked navigates to SignupPage
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const SignupPage();
                  }));
                },
                child: Text(
                  toSignUpString,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w800,
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
