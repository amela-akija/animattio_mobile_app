import 'dart:developer';

import 'package:animattio_mobile_app/pages/during_game/start_game_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// [DatabaseService] contains all of the method that fetch, update or delete data from database.
///
class DatabaseService {
  /// Instance of [FirebaseFirestore] to interact with the database.
  final fireStore = FirebaseFirestore.instance;

  /// [currentUser] is currently signed in user.
  User? currentUser = FirebaseAuth.instance.currentUser;

  /// [addAvatar] method is used to create [avatar] field.
  ///
  /// The method searches for an instance of [currentuser] and updates it with chosen by the user avatar
  ///  and stores the value in [avatar] field.
  ///
  addAvatar(String avatar) {
    try {
      var userCollection = fireStore.collection("users");
      userCollection.doc(currentUser?.uid).update({'avatar': avatar});
    } catch (e) {
      log(e.toString());
    }
  }

/// [checkIfUsernameExists] method is used to ensure all usernames in database are unique.
  ///
  /// The method checks if [username] field in any of the documents of [users] collection is equal to provided username.
  ///
    static Future<bool> checkIfUsernameExists(String username) async {
    final usersCollection = await FirebaseFirestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .get();

    return usersCollection.docs.isNotEmpty;
  }

  /// [removeGamesWithoutResult] removes games that weren't completed by user.
  ///
  /// It checks if the game has a [result] field and if not it removes it from collection.
  ///
  Future<void> removeGamesWithoutResult() async {
    CollectionReference gameCollection =
        FirebaseFirestore.instance.collection("games");
    User? currentUser = FirebaseAuth.instance.currentUser;
    var uid = currentUser?.uid;

    try {
      QuerySnapshot userGames =
          await gameCollection.where("id", isEqualTo: uid).get();

      for (QueryDocumentSnapshot game in userGames.docs) {
        Map<String, dynamic> data = game.data() as Map<String, dynamic>;

        if (!data.containsKey("result")) {
          await game.reference.delete();
          print('Deleted game: ${game.id}');
        }
      }
    } catch (e) {
      print('Error: $e');
    }
  }



  /// [getUserData] retrieves the currently signed in user's data.
  ///
  ///   /// Returns:
  /// - A [Map<String,String>] containing the values from the [username] field.
  ///
  Future<Map<String, String>> getUserData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser.uid)
          .get();

      String username = userData['username'];
      return {'username': username};
    }

    return {'username': ''};
  }

  /// [getAvatar] method retrieves currently signed in user's avatar.
  ///
  /// The method checks if user's data exists in database and returns
  /// value of the [avatar] fields if it exists and if not default image path.
  ///
  Future<String> getAvatar() async {
    try {
      var userCollection = fireStore.collection("users");
      var currentUserData = await userCollection.doc(currentUser?.uid).get();
      if (currentUserData.exists) {
        return currentUserData.data()?['avatar'] ??
            'assets/user_page/no_avatar.png';
      } else {
        return "User doesn't exists";
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  /// [repeatGame] method is used to repeat game's settings.
  ///
  /// It fetches the last completed by user game's settings
  ///   /// Returns:
  /// - A [List<String>] containing the values from the [mode] and [theme] fields.
  ///
  Future<List?> repeatGame() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
      CollectionReference games =
          FirebaseFirestore.instance.collection('games');
      QuerySnapshot lastGame = await games
          .orderBy('timestamp', descending: true)
          .where("id", isEqualTo: userId)
          .limit(1)
          .get();
      if (lastGame.docs.isNotEmpty) {
        DocumentSnapshot lastGameRef = lastGame.docs.first;
        var mode = lastGameRef["mode"];
        var theme = lastGameRef["theme"];
        List modeAndTheme = [];
        modeAndTheme.add(mode);
        modeAndTheme.add(theme);
        return modeAndTheme;
      } else {
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  /// [addGame] method adds a new instance of [ChosenGame] to database.
  ///
  /// It consists of parameters: [userId], [mode], [theme] and adds a game to database
  /// with currently signed in user's id and chosen by them mode and theme.
  ///
  Future<String?> addGame(String userId, String mode, String theme) async {
    String chosenMode = '';
    try {
      if (mode ==
              "Kliknij na ekran tylko wtedy, gdy wyświetlony jest dany symbol" ||
          mode == "Click on the screen only when given symbol is displayed" ||
          mode == "mode1") {
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

  // deleteGame() {
  //   try {
  //     fireStore
  //         .collection("games")
  //         .orderBy('timestamp', descending: true)
  //         .get()
  //         .then((value) {
  //       value.docs.first.reference.delete();
  //     });
  //   } catch (e) {
  //     log(e.toString());
  //   }
  // }

  /// [updateGameWithResult] is a methods that adds all of the calculated game parameters to a game document.
  ///
  /// It updates the currently played game with the fields: [result], [images], [comission], [omission], [hitRate], [rT] and [intervals].
  ///
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
          'shownImages': images,
          'comissionErrors': comission,
          "omissionErrors": omission,
          "hitRate": hitRate,
          "reactionTimes": rT,
          "intervals": intervals
        });
      });
    } catch (e) {
      log(e.toString());
    }
  }

  /// [updateGameWithStimuli] is a method that adds to game randomly chosen stimuli.
  ///
  /// It updates the currently played game with the field [stimuli].
  ///
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

  /// [moveUserData] is method thar removes current user's data from users collection and inserts it into deleted users collection.
  ///
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

  /// [countPlayedGames1] method counts how many games in mode 1 were played by user.
  ///
  ///   /// Returns:
  /// - A [Future<int?>] which is the amount of games played in mode 1.
  ///
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

  /// [countPlayedGames2] method counts how many games in mode 2 were played by user.
  ///
  ///   /// Returns:
  /// - A [Future<int?>] which is the amount of games played in mode 2.
  ///
  Future<int?> countPlayedGames2() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
      QuerySnapshot games = await FirebaseFirestore.instance
          .collection('games')
          .where('id', isEqualTo: userId)
          .where('mode', isEqualTo: "mode2")
          .get();

      int gamesAmount = games.docs.length;
      print("2:$gamesAmount");
      return gamesAmount;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  /// [moveGames1ToTests] method moves 6 completed games in mode 1 by user to tests collection.
  ///
  /// It adds 6 completed games to a list while removing them from games collection.
  /// It then passes the list of games as a field in tests collection.
  ///
  Future<void> moveGames1ToTests() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
      final gamesCollection = FirebaseFirestore.instance.collection('games');

      QuerySnapshot games1 = await gamesCollection
          .where('mode', isEqualTo: "mode1")
          .where('id', isEqualTo: userId)
          .get();
      List<QueryDocumentSnapshot> games = games1.docs;

      // ignore: unused_local_variable
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
            'gamesInTest': test,
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
        print('games ${test.length}');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  /// [moveGames1ToTests] method moves 6 completed games in mode 2 by user to tests collection.
  ///
  /// It adds 6 completed games to a list while removing them from games collection.
  /// It then passes the list of games as a field in tests collection.
  ///
  Future<void> moveGames2ToTests() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String userId = currentUser!.uid;
      final gamesCollection = FirebaseFirestore.instance.collection('games');

      QuerySnapshot games2 = await gamesCollection
          .where('mode', isEqualTo: "mode2")
          .where('id', isEqualTo: userId)
          .get();
      List<QueryDocumentSnapshot> games = games2.docs;
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
            'gamesInTest': test,
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
        print('games 2: ${test.length}');
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
