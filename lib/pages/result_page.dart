import 'package:animattio_mobile_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPage extends StatefulWidget {
  final List<bool> tappedImages;
  final List<String> shownImages;
  const ResultPage(
      {super.key, required this.shownImages, required this.tappedImages});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    //Strings
    String userTitle = "your_result".tr;
    String gameButton = "continue".tr;
    // String result = 'your_result';

    final dbService = DatabaseService();

    //Colors
    Color pageColor = const Color(0xFF2A470C);
    Color buttonColor = const Color(0xFFF7A559);
    Color fontColor = const Color(0xFFFEFFD9);
    Color titleColor = const Color(0xFFFEFFD9);

    //Size
    dynamic deviceSize, height, width;
    deviceSize = MediaQuery.of(context).size;
    height = deviceSize.height;
    width = deviceSize.width;

    List<bool> ignoreFirstValue = widget.tappedImages.sublist(1);

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Text(
              userTitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: fontColor,
                fontSize: 40,
                fontFamily: 'Fredoka',
              ),
            ),
          ),
          ListView.builder(
            itemCount: widget.shownImages.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Expanded(
                    child: Image.asset(
                      widget.shownImages[index],
                      height: 150,
                      width: 150,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      ignoreFirstValue[index] ? 'tapped'.tr : 'not_tapped'.tr,
                      style: TextStyle(
                        color: fontColor,
                        fontSize: 30,
                        fontFamily: 'Fredoka',
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          ElevatedButton(
            onPressed: () {
              dbService.updateGameWithResult(
                  ignoreFirstValue, widget.shownImages);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
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
              'continue'.tr,
              style: TextStyle(color: fontColor),
            ),
          ),
        ],
      ),
    );
  }
}



//     return Scaffold(
//       backgroundColor: pageColor,
//       body:  Stack(
//         children: [Text(
//                   result,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     color: fontColor,
//                     fontSize: 36,
//                     fontFamily: 'Lilita One',
//                   ),
//                 ),
//                 ListView.builder(
//         itemCount: widget.tappedImages.length,
//         itemBuilder: (context, index) {
//           return ListTile(
//             title: Text('Item $index: ${widget.tappedImages[index]}', style: TextStyle(
//                     color: fontColor,
//                     fontSize: 24,
//                     fontFamily: 'Lilita One',
//                   ),),
//           );
//         },
//       ),
//        ElevatedButton(
//                       onPressed: () {
//                          dbService.updateGameWithResult(ignoreFirstValue,widget.shownImages);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: buttonColor,
//                         padding: const EdgeInsets.symmetric(
//                             horizontal: 30, vertical: 10),
//                         textStyle: const TextStyle(
//                             fontSize: 25,
//                             fontFamily: 'Lilita One',
//                             fontWeight: FontWeight.w900),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         elevation: 10,
//                       ),
//                       child: Text(
//                         'continue'.tr,
//                         style: TextStyle(color: fontColor),
//                       ),
//                     ),
//                 ],
//             ),
//       );
//   }
// }