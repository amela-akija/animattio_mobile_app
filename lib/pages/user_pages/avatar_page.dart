import 'package:animattio_mobile_app/pages/user_pages/user_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';

/// AvatarPage is a page that allows user to pick an avatar.
///
/// This page contains of a list of available avatars.
/// The layout includes decorative images positioned around the screen
/// and a field where available avatars are displayed. It includes arrows that help browse through available avatars
///  and a button to save chosen image.
///
class AvatarPage extends StatefulWidget {
  /// Creates a [AvatarPage].
  const AvatarPage({super.key});

  @override
  _ChosenAvatarState createState() => _ChosenAvatarState();
}

class _ChosenAvatarState extends State<AvatarPage> {
  /// [dbService] is an instance of [DatabaseService] used to access all of the methods that interact with the database.
  final dbService = DatabaseService();

  /// [listOfAvatars] is a list of all of the available avatars.
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
  ];

  /// Index to track whick avatar is currently displayed
  int currentAvatar = 0;

  /// [showPreviousAvatar] navigates to the previous avatar in the [listOfAvatars] and updates the displayed avatar.
  ///
  /// The method decrements the index of the current avatar and uses modulo operation so
  /// if it reaches the beginning of the list, the avatars are repeated. With every new avatar [setState] is called.
  ///
  void showPreviousAvatar() {
    setState(() {
      currentAvatar = (currentAvatar - 1) % listOfAvatars.length;
    });
  }

  /// [showNextAvatar] navigates to the next avatar in the [listOfAvatars] and updates the displayed avatar.
  ///
  /// The method increments the index of the current avatar and uses modulo operation so
  /// if it reaches the end of the list, the avatars are repeated. With every new avatar [setState] is called.
  ///
  void showNextAvatar() {
    setState(() {
      currentAvatar = (currentAvatar + 1) % listOfAvatars.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    ///Strings used on page.
    String pageTitle = "Choose your avatar";
    String chooseButton = "Choose";
    String avatar = listOfAvatars[currentAvatar];

    /// Color definitions used throughout the page.
    Color buttonColor = const Color(0xFF2A470C);
    Color chooseColor = const Color(0xFFFEFFD9);
    Color pageColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);

    ///Size of the screen used for a responsive ui.
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    /// Main UI of the page composed of multiple stacked elements.
    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
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
          //Image positioned bottom left (star_avatar_1)
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
                //Field where avatars are displayed
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
              //Button that allows user to go back to UserPage
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
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const UserPage();
                          },
                        ));
                      },
                    ),
                  ),
                ),
              ),
              //Button that when pressed calls [showPreviousAvatar]
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_left),
                  color: chooseColor,
                  iconSize: 40,
                  onPressed: showPreviousAvatar,
                ),
              ),
              //Button that when pressed calls [showNextAvatar]

              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.arrow_right),
                  color: chooseColor,
                  iconSize: 40,
                  onPressed: showNextAvatar,
                ),
              ),
              //Image of current avatar
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: width * 0.25,
                  height: height * 0.25,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset(listOfAvatars[currentAvatar]),
                  ),
                ),
              ),
            ],
          ),
          //Title of the page
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
          //Button to save chosen avatar
          Positioned(
            top: deviceSize.height * 0.8,
            width: deviceSize.width,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  ///When pressed the [addAvatar] function is called and user is navigated to UserPage.
                  dbService.addAvatar(avatar);
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
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
