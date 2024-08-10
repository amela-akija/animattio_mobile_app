import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResultPage extends StatefulWidget {
  final List<bool> tappedImages;
  final List<int> shownImages;
  const ResultPage({super.key, required this.shownImages,required this.tappedImages});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {

  final ScrollController shownImagesController = ScrollController();
  final ScrollController tappedImagesController = ScrollController();
 @override
 //two list scroll at the same time
  void initState() {
    super.initState();

    shownImagesController.addListener(() {
      if (shownImagesController.hasClients && tappedImagesController.hasClients) {
        tappedImagesController.jumpTo(shownImagesController.offset);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    //Strings
    String userTitle = "your_result".tr;
    String gameButton = "continue".tr;
  


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

    // final result = Map.fromIterables(widget.shownImages, widget.tappedImages);

    return Scaffold(
      backgroundColor: pageColor,
      body: Row(
      children: [
        Expanded(
          child: ListView.builder(
            controller:shownImagesController ,
            itemBuilder: (context, index) => Text("main $index"),
          ),
        ),
        Expanded(
          child: ListView.builder(
            controller: tappedImagesController,
            itemBuilder: (context, index) => Text("listener $index"),
          ),
        ),
      ],
    ));
  }
}