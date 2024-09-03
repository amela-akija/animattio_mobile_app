import 'dart:async';
import 'dart:math';
import 'package:animattio_mobile_app/pages/after_game/result_page.dart';
import 'package:flutter/material.dart';
/// GamePage is a page where user completes a block of CPT test in form of one game.
///
/// This page contains of 60 randomly chosen images that are displayed for 250 ms with intervals where no image is shown between them.
///  The images are seperated by intervals, each interval lasts for 20 pictures and they are chosen randomly. 
/// Values of intervals are: 1s, 2s and 4s. 
///  [GamePage] has three parameters [listOfImages], [stimuli] and [mode].
///
class GamePage extends StatefulWidget {
  final String stimuli;
  final List<String> listOfImages;
  final String mode;
  const GamePage(
      {super.key,
      required this.stimuli,
      required this.listOfImages,
      required this.mode});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Random random = Random();
  String? currentImage;
  List<String> shownImages = [];
  List<bool> tappedImages = [];
  // List<String> imagesToShow = [];

  int count = 0;
  int imageIndex = 0;
  int lastIndex = 0;

  Timer? showTimer;
  Timer? hideTimer;

  DateTime? startTime;
  DateTime? endTime;
  Duration? reactionTime;
  int? rT = 0;

  //intervals - interval time in ms + 250 ms
  List<int> intervals = [1250, 2250, 4250];
  List<int> orderOfIntervals = [];

  List<int> reactionTimes = [];

  List<String> imagesToShow() {
  List<String> listOfRandomImages = [widget.stimuli, widget.stimuli];
  Random random = Random();
  while (listOfRandomImages.length < 20) {
    String image = widget.listOfImages[random.nextInt(widget.listOfImages.length)];
    listOfRandomImages.add(image);
  }
  listOfRandomImages.shuffle(random);

  return listOfRandomImages;
}

  @override
  void initState() {
    super.initState();
    tappedImages = List.filled(61, false); 
    startGame();
  }

  void startGame() {
    int interval=intervals.elementAt(Random().nextInt(intervals.length));
    orderOfIntervals.add(interval);
    for(int i=0; i<intervals.length; i++){
      if(interval==intervals[i]){
        intervals.removeAt(i);
      }
    }
    showTimer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (count >= 60) {
        timer.cancel();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ResultPage(
              shownImages: shownImages,
              tappedImages: tappedImages,
              stimuli: widget.stimuli,
              mode: widget.mode,
              reactionTimes: reactionTimes, intervals: orderOfIntervals,
            );
          }),
        );
      } else {
        if(count>=20){
          timer.cancel();
          continueGame();
          return;
        }
        setState(() {
          List<String> block1 = imagesToShow();
          for(int i=0; i<block1.length;i++){
            currentImage = block1[i];
          }
          // currentImage =
          //     block1[random.nextInt(block1.length)];
          startTime = DateTime.now();
          shownImages.add(currentImage!);
          lastIndex++;
          // ignore: avoid_print
          print("Images shown ${shownImages.length}");
          print("Interval $interval");
          count++;
        });

        hideTimer = Timer(const Duration(milliseconds: 250), () {
          setState(() {
            currentImage = null;
          });
        });
      }
    });
  }

  void continueGame() {
    int interval=intervals.elementAt(Random().nextInt(intervals.length));
    orderOfIntervals.add(interval);
    for(int i=0; i<intervals.length; i++){
      if(interval==intervals[i]){
        intervals.removeAt(i);
      }}
    showTimer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (count >= 60) {
        timer.cancel();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ResultPage(
              shownImages: shownImages,
              tappedImages: tappedImages,
              stimuli: widget.stimuli,
              mode: widget.mode,
              reactionTimes: reactionTimes, intervals: orderOfIntervals,
            );
          }),
        );
      } else {
        if(count>=40){
          timer.cancel();
          endGame();
          return;
        }
        setState(() {
          List<String> block2 = imagesToShow();
          for(int i=0; i<block2.length;i++){
            currentImage = block2[i];
          }
          startTime = DateTime.now();
          shownImages.add(currentImage!);
          lastIndex++;
          // ignore: avoid_print
          print("Images shown ${shownImages.length}");
                    print("Interval $interval");

          count++;
        });

        hideTimer = Timer(const Duration(milliseconds: 250), () {
          setState(() {
            currentImage = null;
          });
        });
      }
    });
  }

  void endGame() {
    int interval=intervals.elementAt(Random().nextInt(intervals.length));
    orderOfIntervals.add(interval);
    showTimer = Timer.periodic(Duration(milliseconds: interval), (timer) {
      if (count >= 60) {
        timer.cancel();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ResultPage(
              shownImages: shownImages,
              tappedImages: tappedImages,
              stimuli: widget.stimuli,
              mode: widget.mode,
              reactionTimes: reactionTimes, intervals: orderOfIntervals,
            );
          }),
        );
      } else {
        setState(() {
          List<String> block3 = imagesToShow();
         for(int i=0; i<block3.length;i++){
            currentImage = block3[i];
          }
          startTime = DateTime.now();
          shownImages.add(currentImage!);
          lastIndex++;
          // ignore: avoid_print
          print("Images shown ${shownImages.length}");
                    print("Interval $interval");

          count++;
        });

        hideTimer = Timer(const Duration(milliseconds: 250), () {
          setState(() {
            currentImage = null;
          });
        });
      }
    });
  }

  void tappedImage() {
    endTime = DateTime.now();
    reactionTime = endTime!.difference(startTime!);
    rT = reactionTime?.inMilliseconds;
    print("reaction time $reactionTime");
    reactionTimes.add(rT!);
    tappedImages[lastIndex] = true;
    // ignore: avoid_print
    print("Tapped image $lastIndex");
  }

  @override
  void dispose() {
    showTimer?.cancel();
    hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Colors
    Color pageColor = const Color(0xFFFEFFD9);
    return Scaffold(
      backgroundColor: pageColor,
      body: GestureDetector(
        onTap: () => tappedImage(),
        child: Center(
          child: currentImage != null
              ? Image.asset(currentImage!)
              : Container(
                  color: Colors.transparent,
                  width: double.infinity,
                  height: double.infinity,
                ),
        ),
      ),
    );
  }
}
