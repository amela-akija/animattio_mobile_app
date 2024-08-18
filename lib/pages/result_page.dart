import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPage extends StatefulWidget {
  final List<bool> tappedImages;
  final List<String> shownImages;
  const ResultPage({super.key, required this.shownImages,required this.tappedImages});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

 


  @override
  Widget build(BuildContext context) {
    //Strings
    String userTitle = "your_result".tr;
    String gameButton = "continue".tr;
    String result = 'your_result';
  


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


    return Scaffold(
      backgroundColor: pageColor,
      body:  Stack(
        children: [Text(
                  result,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: fontColor,
                    fontSize: 36,
                    fontFamily: 'Lilita One',
                  ),
                ),
                ListView.builder(
        itemCount: widget.tappedImages.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Item $index: ${widget.tappedImages[index]}', style: TextStyle(
                    color: fontColor,
                    fontSize: 24,
                    fontFamily: 'Lilita One',
                  ),),
          );
        },
      ),
                ],
            ),
      );
  }
}