import 'package:animattio_mobile_app/pages/user_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  _ChosenAvatarState createState() => _ChosenAvatarState();
}

class _ChosenAvatarState extends State<AvatarPage> {
  final dbService = DatabaseService();

  final List<String> listOfAvatars = [
     'assets/themes/animal_theme/animal1.png',
      'assets/themes/animal_theme/animal2.png',
      'assets/themes/animal_theme/animal3.png',
      'assets/themes/animal_theme/animal10.png',
      'assets/themes/animal_theme/animal5.png',
      'assets/themes/animal_theme/animal6.png',
      'assets/themes/animal_theme/animal11.png',
      'assets/themes/animal_theme/animal14.png',
      'assets/themes/animal_theme/animal15.png',


    // TODO: Create custom avatars
  ];
  int currentAvatar = 0;


  void _showPreviousAvatar() {
    setState(() {
      currentAvatar = (currentAvatar - 1) % listOfAvatars.length;
    });
  }

  void _showNextAvatar() {
    setState(() {
      currentAvatar = (currentAvatar + 1) % listOfAvatars.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    //Strings
    String pageTitle = "Choose your avatar";
    String chooseButton = "Choose";
    String avatar = listOfAvatars[currentAvatar];


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
          Stack(
            children: [
              Center(
                child: SizedBox(
                  width: width * 0.3,
                  height: height * 0.3,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset(
                      'assets/avatar_page/avatar_field.png',
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
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_left),
                  color: chooseColor,
                  iconSize: 40,
                  onPressed: _showPreviousAvatar,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  color: chooseColor,
                  iconSize: 40,
                  onPressed: _showNextAvatar,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: width * 0.25,
                  height: height * 0.25,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset(listOfAvatars[currentAvatar]
                    ),
                  ),),
              ),
            ],
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
              ],
            ),
          ),
          Positioned(
            top: deviceSize.height * 0.8,
            width: deviceSize.width,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  dbService.addAvatar(avatar);
                  Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return const UserPage();
                    }));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontFamily: 'Lilita One',
                    fontWeight: FontWeight.w900,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 15,
                ),
                child: Text(
                  chooseButton,
                  style: TextStyle(color: fontColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
