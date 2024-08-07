import 'package:animattio_mobile_app/pages/login_page.dart';
import 'package:animattio_mobile_app/services/auth_service.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final dbService = DatabaseService();
  final GlobalKey<FormState> _formKey = GlobalKey();

  //Registration controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final String avatar = 'assets/user_page/no_avatar.png';

  bool showLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    //Colors
    Color fontColor = const Color(0xFFFEFFD9);
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFF7A559);
    Color inputColor = const Color(0xFFFEFFD9);
    Color textColor = const Color(0xFF2A470C);

    //Strings
    String signUpTitle = "sign_up".tr;
    String toLogInString = "sign_to_log".tr;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: pageColor,
      body: Form(
        key: _formKey,
        child: Column(
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
                                                        if (value!.isEmpty) {
                              return "fields".tr;
                            }else if(!value.contains("@")){
                              return "email_format".tr;
                            }
                                                        return null; //zmiana
                            
                          },
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: deviceSize.height * 0.5,
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
                          obscureText: true,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: deviceSize.height * 0.65,
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
                            if (value!.isEmpty) {
                              return "fields".tr;
                            } else if (value != passwordController.text) {
                              return "password_match".tr;
                            } else {
                              return null;
                            }
                          },                          obscureText: true,

                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: deviceSize.height * 0.8,
                    width: deviceSize.width,
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              showLoading = true;
                            });
                            await AuthServices().registerUser(
                                emailController.text,
                                passwordController.text, usernameController.text, avatar,
                                context);
                            setState(() {
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
class RegisteredUser{
  final String username;
  final String email;
  final String avatar;

  RegisteredUser({required this.username, required this.email, required this.avatar});
  Map<String, dynamic> toMap()=>{"username":username, "email": email, "avatar": avatar};
  }
