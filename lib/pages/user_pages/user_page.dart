import 'package:animattio_mobile_app/pages/user_pages/avatar_page.dart';
import 'package:animattio_mobile_app/pages/user_pages/settings_page.dart';
import 'package:animattio_mobile_app/pages/before_game/theme_page.dart';
import 'package:animattio_mobile_app/pages/user_pages/track_games_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// UserPage is the main page of the account where user can choose from all of the available operations.
///
/// This page contains of 4 buttons: one for choosing custom avatar, one for playing the game,
/// one for choosing app settings and one for seeing game progress.
/// The layout includes decorative images positioned around the screen
/// and an avatar image displayed inside them - default or chosen by user.
/// 
class UserPage extends StatelessWidget {
  /// Creates a [UserPage].
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    ///Strings used on page.
    String userTitle = "my_profile".tr;
    String gameButton = "play_game".tr;
    String settingsButton = "settings".tr;
    String avatarButton = "change_avatar".tr;
    String playedGamesButton = "played_games".tr;

    /// [currentAvatar] is a future that retrieves the current user's avatar from Firestore collection.
    ///
    /// This future calls the [getAvatar] method from [DatabaseService] to asynchronously
    /// fetch the value of [avatar] field from current user's instance in users collection.
    /// 
    Future<String> currentAvatar = DatabaseService().getAvatar();

    /// [dbService] is an instance of [DatabaseService] used to access all of the methods that interact with the database.
    final dbService = DatabaseService();

    // Color definitions used throughout the page.
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);
    Color titleColor = const Color(0xFF2A470C);

    //Size of the screen used for a responsive ui.
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;
    // Main UI of the page composed of multiple stacked elements.
    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          //First image (star_user_3)
          Positioned(
            height: height,
            child: Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                'assets/user_page/star_user_3.png',
              ),
            ),
          ),
          //Second image (star_user_2)
          Positioned(
            left: 0,
            top: height * 0.2,
            width: width * 0.6,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/user_page/star_user_2.png',
              ),
            ),
          ),
          Stack(
            children: [
              //Third image (star_user_1) placed on top of second  image
              Positioned(
                left: 0,
                top: height * 0.24,
                width: width * 0.5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/user_page/star_user_1.png',
                  ),
                ),
              ),
              // A [FutureBuilder] widget that displays an image based on the future provided by the [getAvatar()] method.
              //
              // It displays the avatar image when data is available or shows a
              // loading indicator while waiting for the data.
              FutureBuilder<String>(
                future: currentAvatar,
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return Positioned(
                      bottom: height * 0.45,
                      child: Padding(
                        padding: EdgeInsets.only(top: height * 0.15,),
                        child: SizedBox(
                          height: height * 0.29,
                          child: Image.asset(
                            snapshot.data.toString(),
                            fit: BoxFit.contain,
                            width: width * 0.32,
                          ),
                        ),
                      ),
                    );
                  }
                  return const CircularProgressIndicator(
                    strokeAlign: CircularProgressIndicator.strokeAlignCenter,
                  );
                },
              ),
            ],
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: height * 0.05),
                //Title of the page
                Text(
                  userTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: titleColor,
                    fontSize: 60,
                    fontFamily: 'Lilita One',
                  ),
                ),
                SizedBox(height: height * 0.42), // in the middle of page
                SizedBox(
                  width: width * 0.5,
                  //Button that when pressed navigates to AvatarPage
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const AvatarPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lilita One',
                          fontWeight: FontWeight.w900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      avatarButton,
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: width * 0.5,
                  //Button that when pressed navigates to ThemePage
                  child: ElevatedButton(
                    onPressed: () async{
                      await DatabaseService().moveGames1ToTests();
                      await DatabaseService().moveGames2ToTests();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ThemePage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lilita One',
                          fontWeight: FontWeight.w900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      gameButton,
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: width * 0.5,
                  //Button that when pressed navigates to SettingsPage
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SettingsPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Lilita One',
                          fontWeight: FontWeight.w900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      settingsButton,
                      style: TextStyle(color: fontColor),
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: width * 0.5,
                  //Button that when pressed navigates to TrackGamesPage and calls functions moveGames1ToTests() and moveGames2ToTests()
                  child: ElevatedButton(
                    onPressed: () async {
                      await dbService.moveGames1ToTests();
                      await dbService.moveGames2ToTests();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const TrackGamesPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      textStyle: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Fredoka',
                          fontWeight: FontWeight.w900),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      elevation: 10,
                    ),
                    child: Text(
                      playedGamesButton,
                      style: TextStyle(color: fontColor),
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
