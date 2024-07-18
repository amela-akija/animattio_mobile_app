import 'package:animattio_mobile_app/user_page.dart';
import 'package:flutter/material.dart';

class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  _AvatarPageState createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  final List<String> avatarImages = [
    'assets/avatar_page/avatars/avatar_1.png',
    'assets/avatar_page/avatars/avatar_2.png',
    // TODO: Create custom avatars 
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
    Color buttonColor = const Color(0xFF2A470C);
    Color chooseColor = const Color(0xFFFEFFD9);
    Color pageColor = const Color(0xFF2A470C);
    Color fontColor = const Color(0xFFFEFFD9);

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
          Positioned(
            top: 20, 
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              color: chooseColor,
              iconSize: 30, 
              onPressed: () {
                   Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return const UserPage();
                      }));
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                Text(
                  pageTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: chooseColor,
                    fontSize: 56,
                    fontFamily: 'Lilita One',
                  ),
                ),
                const SizedBox(height: 150),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.arrow_left),
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
                      icon: const Icon(Icons.arrow_right),
                      color: buttonColor,
                      iconSize: 50,
                      onPressed: _showNextAvatar,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.85,
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return const UserPage();
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 15),
                  textStyle: const TextStyle(
                    fontSize: 25,
                    fontFamily: 'Lilita One',
                    fontWeight: FontWeight.w900,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                ),
                child: Text(
                  'Choose',
                  style: TextStyle(color: fontColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
  debugShowCheckedModeBanner: false,
  home: AvatarPage(),
));
