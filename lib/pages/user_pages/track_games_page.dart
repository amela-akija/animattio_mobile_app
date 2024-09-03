import 'package:animattio_mobile_app/pages/user_pages/user_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// TrackGamesPage is the page where user can track how many games were completed.
///
/// This page contains of a container with a message and chosen avatar displayed in it.
///  The layout includes two texts with numbers next to each text. These numbers show how many games of either
///  mode 1 or mode 2 were completed by user.
///
class TrackGamesPage extends StatefulWidget {
  /// Creates a [TrackGamesPage].
  const TrackGamesPage({super.key});

  @override
  State<TrackGamesPage> createState() => _TrackGamesPageState();
}

class _TrackGamesPageState extends State<TrackGamesPage> {
  @override
  Widget build(BuildContext context) {
    /// Color definitions used throughout the page.
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);
    Color messageColor = const Color(0xFF2A470C);

    /// [dbService] is an instance of [DatabaseService].
    final dbService = DatabaseService();

    /// [mode1Amount] and [mode2Amount] are  futures that retrieve the current user's completed games from Firestore collection.
    ///
    /// [mode1Amount] counts completed games in the first mode and [mode2Amount] - completed games in second mode.
    ///
    Future<int?> mode1Amount = dbService.countPlayedGames1();
    Future<int?> mode2Amount = dbService.countPlayedGames2();

    /// [currentAvatar] is a future that retrieves the current user's avatar from Firestore collection.
    ///
    /// This future calls the [getAvatar] method from [DatabaseService] to asynchronously
    /// fetch the value of [avatar] field from current user's instance in users collection.
    ///
    Future<String> currentAvatar = DatabaseService().getAvatar();

    ///Size of the screen used for a responsive ui.
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    /// Main UI of the page composed of multiple stacked elements.
    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                //Container with message displayed
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: messageColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //Current users avatar
                      FutureBuilder<String>(
                        future: currentAvatar,
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: SizedBox(
                                height: width * 0.3,
                                width: width * 0.3,
                                child: Image.asset(
                                  snapshot.data.toString(),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            );
                          }
                          return const SizedBox(
                            height: 10,
                            width: 15.0,
                            child: CircularProgressIndicator(
                              strokeAlign:
                                  CircularProgressIndicator.strokeAlignCenter,
                            ),
                          );
                        },
                      ),
                      //Message explaining how collecting game results works
                      Expanded(
                        child: Text(
                          "result_message".tr,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 20,
                            fontFamily: 'Fredoka',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          //Button that allows user to go back to UserPage
          Positioned(
            left: 0,
            top: height * 0.05,
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: buttonColor,
                iconSize: 30,
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const UserPage();
                  }));
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.3, left: width * 0.3),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        //Text for Mode 1
                        child: Text(
                          "first_mode".tr,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 28,
                            fontFamily: 'Lilita One',
                          ),
                        ),
                      ),
                      Expanded(
                        //FutureBuilder widget that displays asynchronously the mode1Amount which is the result of countPlayedGames1 method
                        child: FutureBuilder<int?>(
                          future: mode1Amount,
                          builder: (BuildContext context,
                              AsyncSnapshot<int?> snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data?.toString() ?? '0',
                                style: TextStyle(
                                  color: fontColor,
                                  fontSize: 24,
                                  fontFamily: 'Lilita One',
                                ),
                              );
                            }
                            return const CircularProgressIndicator(
                              strokeAlign:
                                  CircularProgressIndicator.strokeAlignCenter,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        //Text for Mode 2
                        child: Text(
                          "second_mode".tr,
                          style: TextStyle(
                            color: fontColor,
                            fontSize: 28,
                            fontFamily: 'Lilita One',
                          ),
                        ),
                      ),
                      Expanded(
                        //FutureBuilder widget that displays asynchronously the mode2Amount which is the result of countPlayedGames2 method

                        child: FutureBuilder<int?>(
                          future: mode2Amount,
                          builder: (BuildContext context,
                              AsyncSnapshot<int?> snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data?.toString() ?? '0',
                                style: TextStyle(
                                  color: fontColor,
                                  fontSize: 24,
                                  fontFamily: 'Lilita One',
                                ),
                              );
                            }
                            return const CircularProgressIndicator(
                              strokeAlign:
                                  CircularProgressIndicator.strokeAlignCenter,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
