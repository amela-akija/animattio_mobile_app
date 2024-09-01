import 'dart:developer';

import 'package:animattio_mobile_app/pages/start_game_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class DatabaseService {
  final fireStore = FirebaseFirestore.instance;
  User? currentUser = FirebaseAuth.instance.currentUser;

  addAvatar(String avatar) {
    try {
      var userCollection = fireStore.collection("users");
      userCollection.doc(currentUser?.uid).update({'avatar': avatar});
    } catch (e) {
      log(e.toString());
    }
  }

  updateUserData(String username, String email) {
    try {
      var userCollection = fireStore.collection("users");
      userCollection
          .doc(currentUser?.uid)
          .update({'username': username, "email": email});
    } catch (e) {
      log(e.toString());
    }
  }

  Future<Map<String, String>> getUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      String username = userData['username'];
      String email = userData['email'];

      return {'username': username, 'email': email};
    }

    return {'username': '', 'email': ''};
  }

  Future<String> getAvatar() async {
    try {
      var userCollection = fireStore.collection("users");
      var currentUserData = await userCollection.doc(currentUser?.uid).get();
      if (currentUserData.exists) {
        return currentUserData.data()?['avatar'] ??
            'assets/user_page/no_avatar.png';
      } else {
        return "User doesn't exists"; //!!!
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<List?> repeatGame() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
      CollectionReference games =
          FirebaseFirestore.instance.collection('games');
      QuerySnapshot lastGame =
          await games.orderBy('timestamp', descending: true).limit(1).get();
      if (lastGame.docs.isNotEmpty) {
        DocumentSnapshot lastGameRef = lastGame.docs.first;
        var mode = lastGameRef["mode"];
        var theme = lastGameRef["theme"];
        List modeAndTheme = [];
        modeAndTheme.add(mode);
        modeAndTheme.add(theme);
        return modeAndTheme;
        // ChosenGame chosenGame =
        //     ChosenGame(userId: userId, mode: mode, theme: theme);

        // DocumentReference newGame =
        //     await fireStore.collection('games').add(chosenGame.toMap());
        // return newGame.id;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  Future<String?> addGame(String userId, String mode, String theme) async {
    String chosenMode = '';
    try {
      if (mode ==
              "Kliknij na ekran tylko wtedy, gdy wyświetlony jest dany symbol" ||
          mode == "Click on the screen only when given symbol is displayed" || mode == "mode1") {
        chosenMode = "mode1";
      } else {
        chosenMode = "mode2";
      }
      ChosenGame chosenGame =
          ChosenGame(userId: userId, mode: chosenMode, theme: theme);

      DocumentReference newGame =
          await fireStore.collection('games').add(chosenGame.toMap());
      return newGame.id;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  deleteGame() {
    try {
      fireStore
          .collection("games")
          .orderBy('timestamp', descending: true)
          .get()
          .then((value) {
        value.docs.first.reference.delete();
      });
    } catch (e) {
      log(e.toString());
    }
  }

  updateGameWithResult(List<bool> result, List<String> images, int comission,
      int omission, int hitRate, List<int> rT, List<int> intervals) {
    try {
      fireStore
          .collection("games")
          .orderBy('timestamp', descending: true)
          .get()
          .then((value) {
        value.docs.first.reference.update({
          'result': result,
          'shown images': images,
          'comission errors': comission,
          "omission errors": omission,
          "hit rate": hitRate,
          "reaction times": rT,
          "intervals": intervals
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }

  updateGameWithStimuli(String stimuli) {
    try {
      fireStore
          .collection("games")
          .orderBy('timestamp', descending: true)
          .get()
          .then((value) {
        value.docs.first.reference.update({'stimuli': stimuli});
      });
    } catch (e) {
      log(e.toString());
    }
  }

  Future<void> moveUserData() async {
    try {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .get();

      await FirebaseFirestore.instance
          .collection('deleted users')
          .doc(currentUser?.uid)
          .set(userData.data() as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
    }
  }

  Future<int?> countPlayedGames1() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
      QuerySnapshot games = await FirebaseFirestore.instance
          .collection('games')
          .where('id', isEqualTo: userId)
          .where('mode', isEqualTo: "mode1")
          .get();

      int gamesAmount = games.docs.length;
      print("1:$gamesAmount");
      return gamesAmount;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<int?> countPlayedGames2() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
      QuerySnapshot games = await FirebaseFirestore.instance
          .collection('games')
          .where('userId', isEqualTo: userId)
          .where('mode', isEqualTo: "mode2")
          .get();

      int gamesAmount = games.docs.length;
      print(":$gamesAmount");
      return gamesAmount;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  Future<void> moveGames1ToTests() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
      final gamesCollection = FirebaseFirestore.instance.collection('games');

      QuerySnapshot games1 = await gamesCollection
          .where('mode', isEqualTo: "mode1")
          .where('id', isEqualTo:  userId)
          // .where('result', isNotEqualTo: Null)
          .get();
      List<QueryDocumentSnapshot> games = games1.docs;

      // List<QueryDocumentSnapshot> games = games1.docs.where((doc) {
        // return doc['result'] != null;
      // }).toList();

      int count = 1;

      List<Map<String, dynamic>> test = [];
      List<DocumentReference> gamesToDelete = [];

      for (var game in games) {
        test.add(game.data() as Map<String, dynamic>);
        gamesToDelete.add(game.reference);

        if (test.length == 6) {
          final testsCollection =
              FirebaseFirestore.instance.collection('tests');

          await testsCollection.add({
            'games in test': test,
          });
          count++;

          for (var deletedGame in gamesToDelete) {
            await deletedGame.delete();
          }

          test = [];
          gamesToDelete = [];
        }
      }

      if (test.isNotEmpty) {
        print(
            'games ${test.length}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> moveGames2ToTests() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
      final gamesCollection = FirebaseFirestore.instance.collection('games');

      QuerySnapshot games2 =
          await gamesCollection
          .where('mode', isEqualTo: "mode2")
          .where('id', isEqualTo: userId)
          .get();
      List<QueryDocumentSnapshot> games = games2.docs;
      // List<QueryDocumentSnapshot> games = games2.docs.where((doc) {
        // return doc['result'] != null;
      // }).toList();

      int count = 1;

      List<Map<String, dynamic>> test = [];
      List<DocumentReference> gamesToDelete = [];

      for (var game in games) {
        test.add(game.data() as Map<String, dynamic>);
        gamesToDelete.add(game.reference);

        if (test.length == 6) {
          final testsCollection =
              FirebaseFirestore.instance.collection('tests');

          await testsCollection.add({
            'games in test': test,
          });
          count++;

          for (var deletedGame in gamesToDelete) {
            await deletedGame.delete();
          }

          test = [];
          gamesToDelete = [];
        }
      }

      if (test.isNotEmpty) {
        print(
            'games 2: ${test.length}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
