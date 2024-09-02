import 'package:animattio_mobile_app/pages/user_pages/user_page.dart';
import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    //Colors
    Color pageColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);
    Color messageColor = const Color(0xFF2A470C);

    final dbService = DatabaseService();
    Future<int?> mode1Amount = dbService.countPlayedGames1();
    Future<int?> mode2Amount = dbService.countPlayedGames2();
    Future<String> currentAvatar = DatabaseService().getAvatar();

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;
    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: messageColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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
                padding: EdgeInsets.only(top: height * 0.3, left: width*0.3),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
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
