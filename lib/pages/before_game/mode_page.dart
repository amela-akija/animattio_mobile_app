import 'package:animattio_mobile_app/pages/during_game/start_game_page.dart';
import 'package:animattio_mobile_app/pages/before_game/theme_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

/// ModePage is a page where user chooses in which mode the game should be played.
///
/// This page contains of a list of available modes.
/// The layout includes decorative images positioned around the screen
/// and a field where available modes are displayed. It includes arrows that help browse through available modes
///  and a button to save chosen mode. [ModePage] class has one parameter [chosenTheme].
///
class ModePage extends StatefulWidget {
  final String chosenTheme;
  /// Creates a [ModePage].
  const ModePage({super.key, required this.chosenTheme});

  @override
  _ChooseModeState createState() => _ChooseModeState();
}

class _ChooseModeState extends State<ModePage> {
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

  /// [modes] is a list of available modes
  ///
  List<String> modes = ["mode1".tr, "mode2".tr];

  /// Index of currently displayed mode.
  int currentMode = 0;

  /// [showNextMode] navigates to the next mode in the [modes] and updates the displayed mode.
  ///
  /// The method increments the index of the current mode and uses modulo operation so
  /// if it reaches the end of the list, the modes are repeated. With every new mode [setState] is called.
  ///
  void showNextMode() {
    setState(() {
      currentMode = (currentMode + 1) % modes.length;
    });
  }

  /// [showPreviousMode] navigates to the previous mode in the [modes] and updates the displayed mode.
  ///
  /// The method decrements the index of the current mode and uses modulo operation so
  /// if it reaches the beginning of the list, the modes are repeated. With every new mode [setState] is called.
  ///
  void showPreviousMode() {
    setState(() {
      currentMode = (currentMode - 1 + modes.length) % modes.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    ///Strings used on page.
    String themeTitle = "choose_mode".tr;
    String chosenMode = modes[currentMode];

    /// Color definitions used throughout the page.
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFFFEFFD9);
    Color fontColor = const Color(0xFFF7A559);
    Color arrowColor = const Color(0xFF2A470C);
    Color titleColor = const Color(0xFF2A470C);

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
          Stack(
            children: [
              //Button that allows the user to go back to ThemePage
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
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const ThemePage();
                      }));
                    },
                  ),
                ),
              ),
              //Image positioned bottom left (star_mode_1)
              Positioned(
                left: 0,
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/mode_page/star_mode_1.png',
                  ),
                ),
              ),
              //Field where modes are displayed
              Center(
                child: SizedBox(
                  width: width * 0.2,
                  height: height * 0.25,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset(
                      'assets/mode_page/mode_field.png',
                    ),
                  ),
                ),
              ),
              //Image positioned top right (star_mode_2)
              Positioned(
                right: 0,
                top: 0,
                width: width,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/mode_page/star_mode_2.png',
                  ),
                ),
              ),
            ],
          ),
          //Title of page
          Positioned(
            top: height * 0.1,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                themeTitle,
                style: TextStyle(
                  color: titleColor,
                  fontSize: 50,
                  fontFamily: "Lilita One",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Center(
            //current mode
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              constraints: BoxConstraints(
                maxWidth: deviceSize.width * 0.5,
              ),
              child: Text(
                modes[currentMode],
                style: TextStyle(
                  color: fontColor,
                  fontFamily: "Fredoka",
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                //Button that when pressed calls [showPreviousMode]

                child: IconButton(
                  icon: Icon(Icons.arrow_left, color: arrowColor, size: 50),
                  onPressed: showPreviousMode,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                //Button that when pressed calls [showNextMode]

                child: IconButton(
                  icon: Icon(Icons.arrow_right, color: arrowColor, size: 50),
                  onPressed: showNextMode,
                ),
              ),
            ],
          ),
          //Button that when pressed navigates user to StartGamePage and passes along two parameters which are chosenMode and chosenTheme
          Positioned(
            top: deviceSize.height * 0.75,
            width: deviceSize.width,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => StartGamePage(
                            chosenTheme: widget.chosenTheme,
                            chosenMode: chosenMode,
                          )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
                  'OK',
                  style: TextStyle(color: arrowColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
