import 'package:flutter/material.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  _AvatarPageState createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  final List<String> avatarImages = [
    'assets/avatar_page/avatars/avatar_1.png',
    //'assets/avatar_page/avatars/avatar_2.png',
    // Add more image paths as needed
  ];
  int currentIndex = 0;

  void _showPreviousAvatar() {
    setState(() {
      currentIndex = (currentIndex - 1) % avatarImages.length;
    });
  }

  void _showNextAvatar() {
    setState(() {
      currentIndex = (currentIndex + 1) % avatarImages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    String pageTitle = "Choose your avatar";
    Color fontColor = const Color(0xFFF7A559);
    Color buttonColor = const Color(0xFF2A470C);
    Color chooseColor = const Color(0xFFFEFFD9);
    Color pageColor = const Color(0xFF2A470C);

    return Scaffold(
      backgroundColor: pageColor,
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
              'assets/avatar_page/star_avatar_1.png',
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Transform.scale(
              scale: 1,
              child: Image.asset(
                'assets/avatar_page/star_avatar_2.png',
              ),
            ),
          ),
          Center(
            child: Transform.scale(
              scale: 1.25,
              child: Image.asset(
                'assets/avatar_page/avatar_field.png',
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 30),
                Text(
                  pageTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: chooseColor,
                    fontSize: 56,
                    fontFamily: 'Lilita One',
                  ),
                ),
                SizedBox(height: 50), // Adjust as needed
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_left),
                      color: buttonColor,
                      iconSize: 50,
                      onPressed: _showPreviousAvatar,
                    ),
                    Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(avatarImages[currentIndex]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_right),
                      color: buttonColor,
                      iconSize: 50,
                      onPressed: _showNextAvatar,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(MaterialApp(
  home: AvatarPage(),
));
