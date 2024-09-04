import 'package:animattio_mobile_app/pages/during_game/start_game_page.dart';
import 'package:animattio_mobile_app/pages/user_pages/user_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

/// EndGamePage is a page for informing that the user has finished the game and sking if they want to repeat this game (with the same theme and mode)
///
/// This page contains of two buttons providing two options: yes for repeating the game and no for going back to UserPage.
/// The layout includes decorative images positioned around the screen.
///
class EndGamePage extends StatefulWidget {
  /// Creates a [EndGamePage].
  const EndGamePage({super.key});

  @override
  State<EndGamePage> createState() => _EndGamePageState();
}

class _EndGamePageState extends State<EndGamePage> {
  /// Instance of [FlutterLocalNotificationsPlugin] used for creating notifications from app.
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  /// [initState] is the first method invoked when the state object is inserted into the widget tree.
  ///
  /// It is used to initialize: [FlutterLocalNotificationsPlugin] instance,
  /// settings for Android notifications [AndroidInitializationSettings], [InitializationSettings] and to call [testAdded] method
  ///
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('logo');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
    );

    /// Initializes the local notifications plugin with the defined settings.
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
    testAdded();
  }

  /// [testAdded] method calls [showNotification] method every time a document is deleted from specific Firestore collection.
  ///
  void testAdded() {
    final testsCollection = FirebaseFirestore.instance.collection('games');

    testsCollection.snapshots().listen((snapshot) {
      for (var change in snapshot.docChanges) {
        if (change.type == DocumentChangeType.removed) {
          showNotification();
        }
      }
    });
  }

  /// [requestPermissions] method requests permission from the user to allow the app to send notifications.
  Future<void> requestPermissions() async {
    if (await Permission.notification.isDenied) {
      final status = await Permission.notification.request();

      if (status.isDenied || status.isPermanentlyDenied) {
        print('Permission for notifications not granted');
      }
    }
  }

  /// [showNotification] method creates and displays a custom app notfication.
  ///
  /// It calls first [requestPermissions] method.
  Future<void> showNotification() async {
    await requestPermissions();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: true,
    );

    const NotificationDetails channelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      'congrats'.tr,
      'notification'.tr,
      channelSpecifics,
    );
  }

  @override
  Widget build(BuildContext context) {
    ///Strings used on page.
    String endMessage = "end_message".tr;
    String yesButton = "yes".tr;
    String noButton = "no".tr;

    /// Color definitions used throughout the page.
    Color pageColor = const Color(0xffD4F8B0);
    Color buttonColor = const Color(0xFFF7A559);
    Color fontColor = const Color(0xFFF7A559);
    Color fontButtonColor = const Color(0xFFFEFFD9);

    ///Size of the screen used for a responsive ui.
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    /// [dbService] is an instance of [DatabaseService] used to access all of the methods that interact with the database.

    final dbService = DatabaseService();

    /// Main UI of the page composed of multiple stacked elements.
    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          //Button that allows the user to go back to ResultPage
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
                  Navigator.pop(context);
                },
              ),
            ),
          ),
          Column(
            children: [
              Expanded(
                child: Stack(
                  children: <Widget>[
                    // Image star_start_2
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: width,
                        height: height,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset(
                              'assets/start_game_page/star_start_2.png'),
                        ),
                      ),
                    ),
                    //Image star_start_1
                    Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: width,
                        height: height * 0.85,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset(
                              'assets/start_game_page/star_start_1.png'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 27.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    endMessage,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: fontColor,
                      fontSize: 44,
                      fontFamily: "Fredoka",
                      height: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Button to repeat the game
                      ElevatedButton(
                        onPressed: () async {
                          // When pressed calls methods repeatGame(), moveGames1ToTests() and moveGames2ToTests()
                          List? repeatedGame = await dbService.repeatGame();
                          if (repeatedGame != null &&
                              repeatedGame.length == 2) {
                            var mode = repeatedGame[0];
                            var theme = repeatedGame[1];
                            print("mode$mode");
                            await dbService.moveGames1ToTests();
                            await dbService.moveGames2ToTests();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return StartGamePage(
                                  chosenMode: mode,
                                  chosenTheme: theme,
                                );
                              }),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Failed to repeat the game')),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontFamily: 'Lilita One',
                              fontWeight: FontWeight.w900),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 10,
                        ),
                        child: Text(
                          yesButton,
                          style: TextStyle(color: fontButtonColor),
                        ),
                      ),
                      const SizedBox(width: 30),
                      // Button to go back to UserPage
                      ElevatedButton(
                        onPressed: () async {
                          // When pressed calls methods moveGames1ToTests() and moveGames2ToTests() and navigates to UserPage

                          await dbService.moveGames1ToTests();
                          await dbService.moveGames2ToTests();
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                              return const UserPage();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25, vertical: 10),
                          textStyle: const TextStyle(
                              fontSize: 25,
                              fontFamily: 'Lilita One',
                              fontWeight: FontWeight.w900),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 10,
                        ),
                        child: Text(
                          noButton,
                          style: TextStyle(color: fontButtonColor),
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
