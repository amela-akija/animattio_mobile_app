import 'dart:async';
import 'dart:math';

import 'package:animattio_mobile_app/pages/result_page.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    super.initState();
    tappedImages = List.filled(21, false); //TODO: check length
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
      //TODO: add different intervals
      if (count >= 20) {
        timer.cancel();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ResultPage(
              shownImages: shownImages,
              tappedImages: tappedImages,
              stimuli: widget.stimuli,
              mode: widget.mode,
              reactionTimes: reactionTimes,
            );
          }),
        );
      } else {
        if(count>=5){
          timer.cancel();
          continueGame();
          return;
        }
        setState(() {
          currentImage =
              widget.listOfImages[random.nextInt(widget.listOfImages.length)];
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
      //TODO: add different intervals
      if (count >= 20) {
        timer.cancel();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ResultPage(
              shownImages: shownImages,
              tappedImages: tappedImages,
              stimuli: widget.stimuli,
              mode: widget.mode,
              reactionTimes: reactionTimes,
            );
          }),
        );
      } else {
        if(count>=10){
          timer.cancel();
          endGame();
          return;
        }
        setState(() {
          currentImage =
              widget.listOfImages[random.nextInt(widget.listOfImages.length)];
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
      //TODO: add different intervals
      if (count >= 20) {
        timer.cancel();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return ResultPage(
              shownImages: shownImages,
              tappedImages: tappedImages,
              stimuli: widget.stimuli,
              mode: widget.mode,
              reactionTimes: reactionTimes,
            );
          }),
        );
      } else {
        setState(() {
          currentImage =
              widget.listOfImages[random.nextInt(widget.listOfImages.length)];
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
