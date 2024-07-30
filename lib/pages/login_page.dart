import 'package:animattio_mobile_app/pages/user_page.dart';
import 'package:animattio_mobile_app/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';

//Page for login
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Login controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Colors
    Color fontColor = const Color(0xFFFEFFD9);
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFF7A559);
    Color inputColor = const Color(0xFFFEFFD9);
    Color textColor = const Color(0xFF2A470C);

    //Strings
    String loginTitle = "Log in";
    String toSignUpString = "Don't have an account yet? Sign up";

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // for images to not move when keyboard is active
      backgroundColor: pageColor,
      body: Column(
        children: <Widget>[
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
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
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
                          hintText: 'Enter email:',
                          hintStyle: TextStyle(
                              color: textColor, fontFamily: 'Lilita One'),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
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
                          hintText: 'Enter password:',
                          hintStyle: TextStyle(
                              color: textColor, fontFamily: 'Lilita One'),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: deviceSize.height * 0.7,
                  width: deviceSize.width,
                  child: Center(
                    child: ElevatedButton(
                      onPressed: () async {
                      

                        final message = await AuthServices().loginUser(
                            email: emailController.text,
                            password: passwordController.text,);
                        if (message!.contains('User logged in successfully!')) {
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
                        'Log in',
                        style: TextStyle(color: fontColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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
                    fontFamily: 'Lilita One',
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
